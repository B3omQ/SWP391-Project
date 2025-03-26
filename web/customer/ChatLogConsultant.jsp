<%-- 
    Document   : ChatLogConsultant
    Created on : Mar 18, 2025, 8:22:49 AM
    Author     : LAPTOP
--%>

<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ include file="template/header.jsp" %>
<%@ include file="template/sidebar.jsp" %>
<div class="container-fluid">
    <div class="layout-specing">
        <h2 class="text-center">Lịch Sử Cuộc Trò Chuyện</h2>
        <form id="chatHistoryForm" action="ChatLogConsultant" method="GET">
            <div class="row">
                <div class="col-md-4">
                    <label for="consultantId">Chọn Consultant:</label>
                    <select id="consultantId" name="receiverId" class="form-control">
                        <c:forEach var="staffs" items="${staffs}">
                            <option value="${staffs.id}">${staffs.username}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="col-md-4">
                    <button class="btn btn-primary mt-4" onclick="fetchChatHistory()">Xem lịch sử</button>
                </div>
            </div>
        </form>
        <div class="chat-box mt-4">
            <div id="chatMessages">
                <c:forEach var="message" items="${chatHistory}">
                    <p><strong>${message.senderType}:</strong> ${message.message} <small>(${message.timestamp})</small></p>
                </c:forEach>
            </div>
        </div>
    </div>
</div>
<%@ include file="template/footer.jsp" %>