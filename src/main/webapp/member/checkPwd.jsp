<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="member.dto.MemberDTO"%>

<c:if test="${exists}">true</c:if>
<c:if test="${not exists}">false</c:if>