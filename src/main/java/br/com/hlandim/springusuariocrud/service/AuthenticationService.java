package br.com.hlandim.springusuariocrud.service;

import java.util.Arrays;
import java.util.Objects;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import br.com.hlandim.springusuariocrud.dao.UserInfoDao;
import br.com.hlandim.springusuariocrud.model.UserInfo;

@Service
public class AuthenticationService implements UserDetailsService {

	@Autowired
	private UserInfoDao userDao;

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {

		UserInfo user = userDao.findByUsername(username);
		if (Objects.nonNull(user)) {
			GrantedAuthority authority = new SimpleGrantedAuthority(user.getRole().name());
			UserDetails userDetails = (UserDetails) new User(user.getUsername(), user.getPassword(),
					Arrays.asList(authority));
			return userDetails;
		}

		return null;
	}

}
