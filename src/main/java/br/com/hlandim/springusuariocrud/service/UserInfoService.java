package br.com.hlandim.springusuariocrud.service;

import java.util.List;
import java.util.Objects;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import br.com.hlandim.springusuariocrud.dao.UserInfoDao;
import br.com.hlandim.springusuariocrud.model.UserInfo;

@Service
public class UserInfoService implements IUserInfoService {

	@Autowired
	private UserInfoDao dao;
	
	@Autowired
	private PasswordEncoder encoder;

	@Override
	public UserInfo save(UserInfo userInfo) {
//		UserInfo userDb = findByUsername(userInfo.getUsername());
//		if (Objects.nonNull(userDb)) {
//			userInfo.setId(userDb.getId());
//		}
		userInfo.setPassword(encoder.encode(userInfo.getPassword()));
		dao.save(userInfo);
		return userInfo;
	}

	@Override
	public UserInfo findByUsername(String username) {
		return dao.findByUsername(username);
	}
	
	@Override
	public UserInfo findById(long id) {
		return dao.findOne(id);
	}

	@Override
	public List<UserInfo> list() {
		Iterable<UserInfo> iterable = dao.findAll();
		if(Objects.nonNull(iterable)){
			return (List<UserInfo>) dao.findAll();
		}
		return null;
	}

	@Override
	public void remover(long id) {
		dao.delete(id);
	}
	
	@Override
	public UserInfo getAuthentication() {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		if (authentication == null) {
			return null;
		}
		return findByUsername(authentication.getName());
	}

}
