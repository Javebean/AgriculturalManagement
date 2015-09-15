package com.geariot.dao;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.geariot.entity.Produce;

@Repository
@Transactional
public class ProductDao {
	@Autowired
	private SessionFactory sessionFactory;
	
	private Session getSession(){
		return sessionFactory.getCurrentSession();
	}
	
	public void addPro(Produce pro){
		try{
			getSession().saveOrUpdate(pro);
		}catch(Exception e){
			e.printStackTrace();
			throw new RuntimeException(e);
		}
	}
	
	public Produce getPro(int id){
		try{
			String sql = "from Produce where id = ?";
			return (Produce) getSession().createQuery(sql).setInteger(0, id).uniqueResult();
		}catch(Exception e){
			e.printStackTrace();
			throw new RuntimeException(e);
		}
	}
}
