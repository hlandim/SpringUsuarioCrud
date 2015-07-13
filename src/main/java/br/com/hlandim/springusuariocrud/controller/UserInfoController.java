package br.com.hlandim.springusuariocrud.controller;

import java.security.Principal;
import java.util.Locale;
import java.util.Objects;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import br.com.hlandim.springusuariocrud.model.UserInfo;
import br.com.hlandim.springusuariocrud.service.IUserInfoService;

/**
 * Controler responsável peleas urls de usuarios.
 * 
 * @author hlandim
 */
@Controller
@RequestMapping("/user/**")
public class UserInfoController {

	@Autowired
	private IUserInfoService userInfoService;

	@Autowired
	private MessageSource messageSource;

	/**
	 * Acesso a página principal.
	 * 
	 * @return {@link UserInfo} para o formulario.
	 */
	@RequestMapping(value = "/create", method = RequestMethod.GET)
	public UserInfo create() {
		return new UserInfo();
	}

	/**
	 * Acesso a página de cadastro de usuário.
	 * 
	 * @param userInfo
	 * @param result
	 * @param model
	 * @return pagina de cradastro
	 */
	@RequestMapping(value = "/create/save", method = RequestMethod.POST)
	public String save(@Valid UserInfo userInfo, BindingResult result, Model model) {
		if (result.hasErrors()) {
			return "user/create";
		}
		userInfoService.save(userInfo);
		model.addAttribute("message", messageSource.getMessage("message.user.save", null, Locale.getDefault()));
		return "redirect:/user/create";

	}

	/**
	 * Utilizado para verificar se um usuario já esta cadastrdo.
	 * 
	 * @param username
	 * @return <code>true</code> se existir ou <code>false</code> caso nao exista.
	 */
	@RequestMapping(value = "/checkusername", method = RequestMethod.GET)
	public @ResponseBody String checkUsernameExist(@RequestParam String username) {
		return String.valueOf(Objects.nonNull(userInfoService.findByUsername(username)));
	}

	/**
	 * Acesso a pagina de edicao.
	 * 
	 * @param id
	 * @param model
	 * @return pagina de edicao.
	 */
	@RequestMapping(value = "/edit/{id}", method = RequestMethod.GET)
	public String edit(@PathVariable("id") int id, Model model) {
		UserInfo userInfo = userInfoService.findById(id);
		model.addAttribute("userInfo", userInfo);
		return "user/create";
	}

	/**
	 * Usado para remover um usuario.
	 * 
	 * @param principal
	 * @param httpRequest
	 * @param id
	 * @param model
	 * @return deloga o usuario (se o usuario deletado for o mesmo que esta autenticado) ou retorna para pagina de listagem.
	 */
	@Secured("ROLE_ADMIN")
	@RequestMapping(value = "/remove/{id}", method = RequestMethod.GET)
	public String remove(Principal principal, HttpServletRequest httpRequest, @PathVariable("id") long id,
			Model model) {
		UserInfo userInfo = userInfoService.findById(id);
		UserInfo usuarioLogado = userInfoService.findByUsername(principal.getName());
		userInfoService.remover(id);
		model.addAttribute("message", messageSource.getMessage("message.user.removed",
				new Object[] { userInfo.getName() }, Locale.getDefault()));
		if (id == usuarioLogado.getId()) {
			return "redirect:/logout?logout";
		}
		return "redirect:/";
	}

}
