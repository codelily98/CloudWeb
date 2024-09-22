<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="member.dao.MemberDAO"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>

<c:if test="${result}">true</c:if>
<c:if test="${!result}">false</c:if>