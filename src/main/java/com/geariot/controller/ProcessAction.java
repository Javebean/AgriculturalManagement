package com.geariot.controller;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.zip.ZipInputStream;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.activiti.engine.ActivitiException;
import org.activiti.engine.HistoryService;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.history.HistoricProcessInstance;
import org.activiti.engine.identity.User;
import org.activiti.engine.repository.ProcessDefinition;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Task;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.DefaultResourceLoader;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.geariot.dao.ProductDao;
import com.geariot.entity.Produce;
import com.geariot.service.ProductService;
import com.geariot.service.WorkflowTraceService;
import com.geariot.util.Constant;

@Controller
public class ProcessAction {
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private ProductDao productDao;
	@Autowired
	private ProductService productService;
	@Autowired
	private RuntimeService runtimeService;
	@Autowired
	private TaskService taskService;
	@Autowired
	private RepositoryService repositoryService;
	@Autowired
	private HistoryService historyService;
	@Autowired
	private WorkflowTraceService traceService;
	/*�鿴�Ѿ����������*/
	@RequestMapping(value = "/process-list")
	public String processList(Map<String,Object> map) {
		List<ProcessDefinition> list = repositoryService.createProcessDefinitionQuery().list();
		map.put("proDeList", list);
	
		return "innerHtml/proDeList";
	}
	/*��������*/
	@ResponseBody
	@RequestMapping("/deployProcess.do")
	public String deployProcess() throws IOException{
		ResourceLoader resourceLoader = new DefaultResourceLoader();
		/*�õ���Դ��ַ*/
		String classpathResourceUrl = "classpath:/deployment/Agricultural.bar";
		logger.debug("read workflow from: {}", classpathResourceUrl);
		/*ͨ����ַ�õ�Resource*/
		Resource resource = resourceLoader.getResource(classpathResourceUrl);
		/*Resource���Եõ�inputStream,File,Url...*/
		InputStream inputStream = resource.getInputStream();
		if (inputStream == null) {
			logger.warn("ignore deploy workflow module: {}", classpathResourceUrl);
		} else {
			logger.debug("finded workflow module: {}, deploy it!", classpathResourceUrl);
			/*Creates a new ZIP input stream.*/
			ZipInputStream zis = new ZipInputStream(inputStream);
			/*����һ���µĲ��� ������zip�ļ�*/
			repositoryService.createDeployment().addZipInputStream(zis)
			/*Deploys all provided sources to the Activiti engine.*/
			.deploy();
		}
		
		return "success";
	}
	
	/*ɾ������*/
	@RequestMapping("/deleteProcess.do")
	public String deleteProcess(@RequestParam String deploymentId){
		repositoryService.deleteDeployment(deploymentId, true);
		return "redirect:process-list.do";
	}
	
	
	
	
	/*��������*/
	@ResponseBody
	@RequestMapping("/startProcess.do")
	public String startProcess(Produce pro,HttpSession session,Map<String,Object> map) {
		startCollect(pro, session);
		return "success";
	}
	private void startCollect(Produce pro, HttpSession session) {
		try{
			productService.startProcess(pro);
			
			/*�ɼ���Ա�������̣�Ȼ��ֱ��ǩ�������������*/
			User user = (User)session.getAttribute("user");
			String userId = user.getId();
			
			List<Task> unsignedTasks = taskService.createTaskQuery()
					.taskCandidateUser(userId).orderByTaskPriority().desc()
					.orderByTaskCreateTime().desc().list();
			String taskId =  unsignedTasks.get(0).getId();
			taskService.claim(taskId, userId);
			/*�������*/
			System.out.println("will complete task===========");
			taskService.complete(taskId);
			
			
		}catch (ActivitiException e) {
			if (e.getMessage().indexOf("no processes deployed with key") != -1) {
				logger.warn("û�в�������!", e);
				//redirectAttributes.addFlashAttribute("error", "û�в������̣�����[������]->[���̹���]ҳ����<���²�������>");
			} else {
				logger.error("����Ͷ������ʧ�ܣ�", e);
				//redirectAttributes.addFlashAttribute("error", "ϵͳ�ڲ�����");
			}
		} catch (Exception e) {
			logger.error("����Ͷ������ʧ�ܣ�", e);
			//redirectAttributes.addFlashAttribute("error", "ϵͳ�ڲ�����");
		}
	}
	
	/*@RequestMapping("/startProcess2.do")
	public String startProcess2(Produce pro,HttpSession session,Map<String,Object> map) {
		try{
		�ɼ���Ա�������̣�Ȼ��ֱ��ǩ�������������
		User user = (User)session.getAttribute("user");
		String userId = user.getId();
		
		List<Task> todoList = taskService.createTaskQuery()
				.taskAssignee(userId).orderByTaskPriority().desc()
				.orderByTaskCreateTime().desc().list();
		String taskId =  unsignedTasks.get(0).getId();
		taskService.claim(taskId, userId);
		�������
		System.out.println("will complete task===========");
		taskService.complete(taskId);
		}catch (Exception e) {
			logger.error("����Ͷ������ʧ�ܣ�", e);
			//redirectAttributes.addFlashAttribute("error", "ϵͳ�ڲ�����");
		}
		
		return "redirect:findtodoTasks.do";
	}*/

	@RequestMapping("/findtodoTasks.do")
	public String findtodoTasks(HttpSession session, Map<String, Object> map) {
		User u = (User) session.getAttribute("user");
		if(u==null){
			return "redirect:logout.do";
		}
		
		String userId = u.getId();
		List<Task> tasks = new ArrayList<Task>();
		List<Task> todoList = taskService.createTaskQuery()
				.taskAssignee(userId).orderByTaskPriority().desc()
				.orderByTaskCreateTime().desc().list();
		System.out.println(todoList.size() + "==============");
		// ���ݵ�ǰ��δǩ�յ�����
		List<Task> unsignedTasks = taskService.createTaskQuery()
				.taskCandidateUser(userId).orderByTaskPriority().desc()
				.orderByTaskCreateTime().desc().list();

		System.out.println(unsignedTasks.size() + "==============");
		tasks.addAll(todoList);
		tasks.addAll(unsignedTasks);

		List<Produce> results = new ArrayList<Produce>();
		for (Task task : tasks) {
			String processInstanceId = task.getProcessInstanceId();

			ProcessInstance processInstance = runtimeService
					.createProcessInstanceQuery()
					.processInstanceId(processInstanceId).singleResult();

			String businessKey = processInstance.getBusinessKey();

			Produce dispatch = productDao.getPro(new Integer(businessKey));

			dispatch.setTask(task);
			dispatch.setProcessInstance(processInstance);

			dispatch.setProcessDefinition(getProcessDefinition(processInstance.getProcessDefinitionId()));

			results.add(dispatch);

		}
		map.put("todoList", results);
		return "ddcl";
	}
	
	/*ǩ������*/
	@RequestMapping(value = "claimTask.do")
	public String claimTask(@RequestParam("id") String taskId, HttpSession session) {
		User user = (User)session.getAttribute("user");
		String userId = user.getId();
		taskService.claim(taskId, userId);
		return "redirect:findtodoTasks.do";
	}
	
	
	/*�������*/
	@RequestMapping("/completeTask.do")
	public String completeTask(@RequestParam("id") String taskId,String assignee,boolean sta) {
			Map<String,Object> var = new HashMap<String, Object>();
			if(assignee.equals("JGRY")){
				var.put("localPass", sta);
				System.out.println(var+"^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^");
			}else if(assignee.equals("SJRY")){
				var.put("pucPass", sta);
			}
			taskService.complete(taskId,var);
			return "redirect:findtodoTasks.do";
	}
	
	@RequestMapping("/completeReCollect.do")
	public String completeReCollect(Produce pro , String tid){
		productDao.addPro(pro);
		taskService.complete(tid);
		return "redirect:findtodoTasks.do";
	}
	
	@RequestMapping("/completeReportTask.do")
	public String completeReportTask(@RequestParam("id") String businessKey,String reportName,String reportReason,String taskId){
		Produce pro = productDao.getPro(new Integer(businessKey));
		pro.setReportName(reportName);
		pro.setReportReason(reportReason);
		//pro.setId(new Integer(businessKey));
		productDao.addPro(pro);
		
		taskService.complete(taskId);
		return "redirect:findtodoTasks.do";
	}
	
	
	
	@RequestMapping("/findRunningProcessInstaces.do")
	public String findRunningProcessInstaces(Map<String,Object> map){
		List<Produce> results = new ArrayList<Produce>();
		List<ProcessInstance> list = runtimeService.createProcessInstanceQuery().processDefinitionKey(Constant.ProcessInstanceKey).list();
		// ����ҵ��ʵ��
				for (ProcessInstance processInstance : list) {
					String businessKey = processInstance.getBusinessKey();
					Produce dispatch = productDao.getPro(new Integer(businessKey));
					dispatch.setProcessInstance(processInstance);
					
					dispatch.setProcessDefinition(getProcessDefinition(processInstance.getProcessDefinitionId()));
					results.add(dispatch);
					// ���õ�ǰ������Ϣ
					List<Task> tasks = taskService.createTaskQuery().processInstanceId(processInstance.getId()).orderByTaskCreateTime()
							.desc().listPage(0, 1);
					dispatch.setTask(tasks.get(0));
				}
				map.put("runningList", results);
				
		return "yxzlc";
	}
	
	
	@RequestMapping("/findFinishedProcessInstaces.do")
	public String findFinishedProcessInstaces(Map <String ,Object> map) {
		List<Produce> results = new ArrayList<Produce>();
		List<HistoricProcessInstance> list = historyService.createHistoricProcessInstanceQuery().processDefinitionKey(Constant.ProcessInstanceKey)
				.finished().list();

		// ����ҵ��ʵ��
		for (HistoricProcessInstance historicProcessInstance : list) {
			String businessKey = historicProcessInstance.getBusinessKey();
			Produce dispatch = productDao.getPro(new Integer(businessKey));
			
			System.out.println(dispatch);
			/*ʵ��dispatch�е����̶������ʷ����ʵ��Ϊ�գ�������߹���һ��*/
			dispatch.setProcessDefinition(getProcessDefinition(historicProcessInstance.getProcessDefinitionId()));
			dispatch.setHistoricProcessInstance(historicProcessInstance);
			results.add(dispatch);
		}
		System.out.println(results.size()+"**");
		map.put("finishedList", results);
		return "yjslc";
	}

	private ProcessDefinition getProcessDefinition(String processDefinitionId) {
		ProcessDefinition processDefinition = repositoryService.createProcessDefinitionQuery()
				.processDefinitionId(processDefinitionId).singleResult();
		return processDefinition;
	}
	
	
	/*��ȡͼƬ��Դ*/
	@RequestMapping(value = "/loadPicByProcessInstance.do")
	public void loadPicByProcessInstance(@RequestParam("type") String resourceType, @RequestParam("pid") String processInstanceId,
			HttpServletResponse response) throws Exception {
		InputStream resourceAsStream = null;
		ProcessInstance processInstance = runtimeService.createProcessInstanceQuery().processInstanceId(processInstanceId)
				.singleResult();
		ProcessDefinition singleResult = repositoryService.createProcessDefinitionQuery()
				.processDefinitionId(processInstance.getProcessDefinitionId()).singleResult();

		String resourceName = "";
		if (resourceType.equals("image")) {
			resourceName = singleResult.getDiagramResourceName();
		} else if (resourceType.equals("xml")) {
			resourceName = singleResult.getResourceName();
		}
		resourceAsStream = repositoryService.getResourceAsStream(singleResult.getDeploymentId(), resourceName);
		byte[] b = new byte[1024];
		int len = -1;
		while ((len = resourceAsStream.read(b, 0, 1024)) != -1) {
			response.getOutputStream().write(b, 0, len);
		}
	}
	
	@RequestMapping(value = "traceProcess.do")
	@ResponseBody
	public List<Map<String, Object>> traceProcess(@RequestParam("pid") String processInstanceId) throws Exception {
		List<Map<String, Object>> activityInfos = traceService.traceProcess(processInstanceId);
		return activityInfos;
	}
	
	
	/*���̲����е�xml��png����ʾ*/
	@RequestMapping(value = "/loadByDeployment.do")
	public void loadByDeployment(@RequestParam("deploymentId") String deploymentId,
			@RequestParam("resourceName") String resourceName, HttpServletResponse response) throws Exception {
		InputStream resourceAsStream = repositoryService.getResourceAsStream(deploymentId, resourceName);
		byte[] b = new byte[1024];
		int len = -1;
		while ((len = resourceAsStream.read(b, 0, 1024)) != -1) {
			response.getOutputStream().write(b, 0, len);
		}
	}
	
	@ResponseBody
	@RequestMapping("/getProduce.do")
	public Produce getProduce(int id){
		return productDao.getPro(id);
	}

}