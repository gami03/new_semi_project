package com.action;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.ActionForward;

public interface Action {
	
	public ActionForward excute(HttpServletRequest request, HttpServletResponse response) throws IOException;



}
