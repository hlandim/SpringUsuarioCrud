package br.com.hlandim.springusuariocrud.dao;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import br.com.hlandim.springusuariocrud.model.UserInfo;

/**
 * Interface de abstrcao do crud.
 * @author hlandim
 *
 */
@Repository
public interface UserInfoDao extends CrudRepository<UserInfo, Long>{

	public UserInfo findByUsername(String username);
	
}
