package com.geariot.service;

import java.util.Date;

import org.activiti.engine.RuntimeService;
import org.activiti.engine.runtime.ProcessInstance;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.geariot.dao.ProductDao;
import com.geariot.entity.Produce;
import com.geariot.util.Constant;
@Service
public class ProductService {
	@Autowired
	private ProductDao productDao;
	@Autowired
	private RuntimeService runtimeService;

	@Transactional
	public void startProcess(Produce pro) {

		pro.setApplyTime(new Date());
		productDao.addPro(pro);

		ProcessInstance processInstance = runtimeService
				.startProcessInstanceByKey(Constant.ProcessInstanceKey,
						pro.getId() + "");
		pro.setProcessInstance(processInstance);
	}
}
