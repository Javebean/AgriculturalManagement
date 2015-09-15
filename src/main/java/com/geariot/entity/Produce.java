package com.geariot.entity;

import java.util.Date;
import java.util.Map;

import org.activiti.engine.history.HistoricProcessInstance;
import org.activiti.engine.repository.ProcessDefinition;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Task;
import org.springframework.format.annotation.DateTimeFormat;

public class Produce {
	private String processInstanceId;
	
	
	private int id;
	private String proName;
	private String proType;
	private String proPlace;
	private String proLev;//鍒濈骇 鍒濈骇鍔犲伐 鍚嶄紭
	
	private String reportName;
	private String reportReason;
	
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
	private Date applyTime;
	
	private String isSave;//0:没有归档  1：已经归档
	
	
	//-- 涓存椂灞炴� --//
	
	// 娴佺▼浠诲姟
	private Task task;
	
	private Map<String, Object> variables;
	
	// 杩愯涓殑娴佺▼瀹炰緥
	private ProcessInstance processInstance;
	
	// 鍘嗗彶鐨勬祦绋嬪疄渚�
	private HistoricProcessInstance historicProcessInstance;
	
	// 娴佺▼瀹氫箟
	private ProcessDefinition processDefinition;

	public String getProcessInstanceId() {
		return processInstanceId;
	}

	public void setProcessInstanceId(String processInstanceId) {
		this.processInstanceId = processInstanceId;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getProName() {
		return proName;
	}

	public void setProName(String proName) {
		this.proName = proName;
	}

	public String getProType() {
		return proType;
	}

	public void setProType(String proType) {
		this.proType = proType;
	}

	public String getProPlace() {
		return proPlace;
	}

	public void setProPlace(String proPlace) {
		this.proPlace = proPlace;
	}

	public String getProLev() {
		return proLev;
	}

	public void setProLev(String proLev) {
		this.proLev = proLev;
	}

	public String getReportName() {
		return reportName;
	}

	public void setReportName(String reportName) {
		this.reportName = reportName;
	}

	public String getReportReason() {
		return reportReason;
	}

	public void setReportReason(String reportReason) {
		this.reportReason = reportReason;
	}

	public Date getApplyTime() {
		return applyTime;
	}

	public void setApplyTime(Date applyTime) {
		this.applyTime = applyTime;
	}

	public Task getTask() {
		return task;
	}

	public void setTask(Task task) {
		this.task = task;
	}

	public Map<String, Object> getVariables() {
		return variables;
	}

	public void setVariables(Map<String, Object> variables) {
		this.variables = variables;
	}

	public ProcessInstance getProcessInstance() {
		return processInstance;
	}

	public void setProcessInstance(ProcessInstance processInstance) {
		this.processInstance = processInstance;
	}

	public HistoricProcessInstance getHistoricProcessInstance() {
		return historicProcessInstance;
	}

	public void setHistoricProcessInstance(
			HistoricProcessInstance historicProcessInstance) {
		this.historicProcessInstance = historicProcessInstance;
	}

	public ProcessDefinition getProcessDefinition() {
		return processDefinition;
	}

	public void setProcessDefinition(ProcessDefinition processDefinition) {
		this.processDefinition = processDefinition;
	}

	public String getIsSave() {
		return isSave;
	}

	public void setIsSave(String isSave) {
		this.isSave = isSave;
	}
	
	
	
}
