package br.com.hlandim.springusuariocrud.model;

import java.time.LocalDate;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.format.annotation.DateTimeFormat;

/**
 * Classe que representa o usuario do sistema
 * 
 * @author hlandim
 *
 */
@Entity
public class UserInfo {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Long id;

	@Column(unique = true)
	@NotEmpty
	@Size(max = 50)
	private String username;

	@Column
	@NotEmpty
	private String name;

	@Column
	@NotEmpty
	private String password;

	@DateTimeFormat(pattern = "dd/MM/yyyy")
	@Column
	@NotNull
	private LocalDate birthdate;

	@Column
	@NotNull
	@Enumerated(EnumType.STRING)
	private Role role;

	public UserInfo() {
	}

	public UserInfo(String username, String password, Role role, String name, LocalDate birthdate) {
		super();
		this.username = username;
		this.password = password;
		this.role = role;
		this.name = name;
		this.birthdate = birthdate;
	}

	public LocalDate getBirthdate() {
		return birthdate;
	}

	public void setBirthdate(LocalDate birthdate) {
		this.birthdate = birthdate;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public Role getRole() {
		return role;
	}

	public void setRole(Role role) {
		this.role = role;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public enum Role {
		ROLE_USER, ROLE_ADMIN;

	}

}
