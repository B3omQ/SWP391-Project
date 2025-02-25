<!DOCTYPE html>
<!--
Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Html.html to edit this template
-->

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>WebSocket Chat</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
        }
        #chatBox {
            width: 60%;
            height: 300px;
            border: 1px solid #ccc;
            overflow-y: auto;
            padding: 10px;
            margin: 10px auto;
            text-align: left;
        }
        input, button {
            padding: 10px;
            margin: 5px;
        }
    </style>
</head>
<body>

<h2>WebSocket Chat</h2>
<div id="chatBox"></div>

<input type="text" id="receiver" placeholder="Receiver Username">
<input type="text" id="message" placeholder="Enter message">
<button onclick="sendMessage()">Send</button>

<script>
    let username = sessionStorage.getItem("username");

    if (!username) {
        username = "guest-" + Math.floor(Math.random() * 10000);
        sessionStorage.setItem("username", username);
    }

    let socket = new WebSocket("ws://localhost:9999/BankingSystem/chat");

    socket.onopen = function () {
        console.log("Connected as " + username);
        addMessage("Bạn đã kết nối vào chat với tên: " + username, "system");
    };

    socket.onmessage = function (event) {
        addMessage(event.data, "message");
    };

    socket.onerror = function (event) {
        console.error("WebSocket error:", event);
        addMessage("Lỗi kết nối WebSocket!!", "error");
    };

    socket.onclose = function (event) {
        console.log("Disconnected from WebSocket server");
        addMessage("Kết nối WebSocket đã đóng!", "system");
    };

    function sendMessage() {
        if (socket.readyState !== WebSocket.OPEN) {
            alert("WebSocket chưa kết nối. Hãy thử lại sau.");
            return;
        }
        
        let receiver = document.getElementById("receiver").value.trim();
        let message = document.getElementById("message").value.trim();

        if (!receiver || !message) {
            alert("Vui lòng nhập người nhận và tin nhắn.");
            return;
        }

        let data = receiver + ": " + message;
        socket.send(data);
        document.getElementById("message").value = "";
        addMessage("Bạn -> " + receiver + ": " + message, "sent");
    }

    function addMessage(text, type) {
        let chatBox = document.getElementById("chatBox");
        let messageElement = document.createElement("p");
        
        if (type === "system") {
            messageElement.style.color = "blue";
        } else if (type === "error") {
            messageElement.style.color = "red";
        } else if (type === "sent") {
            messageElement.style.color = "green";
        }

        messageElement.textContent = text;
        chatBox.appendChild(messageElement);
        chatBox.scrollTop = chatBox.scrollHeight;
    }
</script>

</body>
</html>



