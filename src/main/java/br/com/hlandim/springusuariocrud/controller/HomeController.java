package br.com.hlandim.springusuariocrud.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import br.com.hlandim.springusuariocrud.service.IUserInfoService;

/**
 * Controller respánsavel pelas chamadas a url principal.
 * @author hlandim
 *
 */
@Controller
public class HomeController {

	@Autowired
	private IUserInfoService userInfoService;

	@Autowired

	@RequestMapping(value = "/")
	public ModelAndView index(HttpServletRequest httpRequest) throws IOException {
		ModelAndView modelAndView = new ModelAndView("home");
		modelAndView.addObject("usuarios", userInfoService.list());
		modelAndView.addObject("usuarioLogado", userInfoService.getAuthentication());
		return modelAndView;
	}

}
