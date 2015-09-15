package com.geariot.controller;

import org.activiti.engine.IdentityService;
import org.activiti.engine.identity.Group;
import org.activiti.engine.identity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;

@Controller
public class UserAction {
	@Autowired
	private IdentityService identityService;
	
	@RequestMapping("/login.do")
	public String login(String username,String password,HttpSession session){
		boolean isLogin = identityService.checkPassword(username, password);
		System.out.println(isLogin+"*************");
		if(isLogin){
			User user = identityService.createUserQuery().userId(username).singleResult();
			session.setAttribute("user", user);
			
			Group group = identityService.createGroupQuery().groupMember(username).singleResult();
			session.setAttribute("group", group);
		}
		return "redirect:index.jsp";
	}
	
	@RequestMapping(value = "/logout")
	public String logout(HttpSession session) {
		session.removeAttribute("user");
		return "redirect:login.html";
	}
}
