package br.com.hlandim.springusuariocrud.service;

import java.util.List;

import br.com.hlandim.springusuariocrud.model.UserInfo;

public interface IUserInfoService {
	
	UserInfo save(UserInfo userInfo);
	
	UserInfo findByUsername(String username);
	
	List<UserInfo> list();
	
	void remover(long id);

	UserInfo findById(long id);

	UserInfo getAuthentication();
	
}
