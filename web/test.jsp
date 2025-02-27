<!DOCTYPE html>
<!--
Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Html.html to edit this template
-->

<%@page contentType="text/html" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>SmartBank Chat</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                display: flex;
                height: 100vh;
            }
            #user-list {
                width: 25%;
                border-right: 2px solid #ccc;
                padding: 10px;
                overflow-y: auto;
            }
            #chat-box {
                flex: 1;
                display: flex;
                flex-direction: column;
                padding: 10px;
            }
            #messages {
                flex: 1;
                border: 1px solid #ccc;
                padding: 10px;
                overflow-y: auto;
                height: 400px;
            }
            input, button {
                margin-top: 5px;
            }
            .user-item {
                cursor: pointer;
                padding: 5px;
                border-bottom: 1px solid #ddd;
            }
            .user-item:hover {
                background-color: #f0f0f0;
            }
        </style>
    </head>
    <body>

        <!-- Danh sách người dùng online -->
        <div id="user-list">
            <h3>Chọn người để chat</h3>
            <ul id="online-users"></ul>
        </div>

        <!-- Hộp chat -->
        <div id="chat-box">
            <h2>SmartBank Support - Chat System</h2>
            <h3 id="chat-with">Chưa chọn người để chat</h3>
            <div id="messages"></div>
            <input type="text" id="message-input" placeholder="Nhập tin nhắn...">
            <button onclick="sendMessage()">Gửi</button>
        </div>

        <script>
            const socket = new WebSocket("ws://localhost:9999/BankingSystem/chat");
            let currentRecipient = null;

            socket.onopen = function () {
                console.log("WebSocket kết nối thành công.");
            };

            socket.onmessage = function (event) {
                console.log("Dữ liệu từ server:", event.data);

                if (event.data.startsWith("STAFF:") || event.data.startsWith("CUSTOMER:") || event.data.startsWith("GUEST:")) {
                    updateOnlineUsers(event.data);
                } else {
                    let messagesDiv = document.getElementById("messages");
                    let messageElem = document.createElement("div");
                    if (event.data.includes(":")) {
                        const [sender, chatMessage] = event.data.split(":", 2);
                        if (chatMessage && chatMessage.trim() !== "") { // Chỉ hiển thị nếu có nội dung
                            messageElem.innerText = sender.trim()+": "+chatMessage.trim();
                                            } else {
                                                messageElem.innerText = event.data; // Hiển thị thông báo hệ thống nếu cần
                                            }
                                        } else {
                                            messageElem.innerText = event.data; // Hiển thị thông báo hệ thống
                                        }
                                        messagesDiv.appendChild(messageElem);
                                        messagesDiv.scrollTop = messagesDiv.scrollHeight;
                                    }
                                };


                                function updateOnlineUsers(data) {
                                    const parts = data.split("|");

                                    const staffData = parts.find(p => p.startsWith("STAFF:")) || "STAFF:";
                                    const customerData = parts.find(p => p.startsWith("CUSTOMER:")) || "CUSTOMER:";
                                    const guestData = parts.find(p => p.startsWith("GUEST:")) || "GUEST:";

                                    const staffList = staffData.replace("STAFF:", "").split(",").filter(u => u);
                                    const customerList = customerData.replace("CUSTOMER:", "").split(",").filter(u => u);
                                    const guestList = guestData.replace("GUEST:", "").split(",").filter(u => u);

                                    const userListElem = document.getElementById("online-users");
                                    userListElem.innerHTML = "";

                                    function createUserItem(username, role) {
                                        const li = document.createElement("li");
                                        li.textContent = "Online " + role + " " + username;
                                        li.className = "user-item";
                                        li.onclick = function () {
                                            currentRecipient = username; // Đảm bảo gán đúng
                                            console.log("Đã chọn người nhận:", currentRecipient, "Kiểu:", typeof currentRecipient); // Log để kiểm tra
                                            document.getElementById("chat-with").textContent = "Đang chat với: " + username;
                                            document.getElementById("messages").innerHTML = "";
                                        };
                                        userListElem.appendChild(li);
                                    }

                                    staffList.forEach(user => createUserItem(user, "staff"));
                                    customerList.forEach(user => createUserItem(user, "customer"));
                                    guestList.forEach(user => createUserItem(user, "guest"));
                                }


                                function sendMessage() {
//                                    let inputElem = document.getElementById("message-input")
                                    let message = document.getElementById("message-input").value.trim();
                                    // Kiểm tra currentRecipient kỹ hơn
                                    if (!currentRecipient || currentRecipient.trim() === "") {
                                        alert("Vui lòng chọn người nhận từ danh sách online. currentRecipient hiện tại: " + (currentRecipient || "undefined"));
                                        return;
                                    }
                                    // Kiểm tra message
                                    if (message === "") {
                                        alert("Vui lòng nhập nội dung tin nhắn. message hiện tại: " + message);
                                        return;
                                    }
                                    if (socket.readyState !== WebSocket.OPEN) {
                                        alert("Kết nối chưa sẵn sàng. Vui lòng đợi.");
                                        return;
                                    }

                                    console.log("Trước khi ghép chuỗi - currentRecipient:", currentRecipient, "Kiểu:", typeof currentRecipient);
                                    console.log("Trước khi ghép chuỗi - message:", message, "Kiểu:", typeof message);

                                    let messageToSend = currentRecipient.trim() + ": " + message; // Đổi tên để tránh xung đột
                                    console.log("Sau khi ghép chuỗi - messageToSend:", messageToSend, "Kiểu:", typeof messageToSend);
                                    console.log("Gửi tin nhắn (trước gửi):", messageToSend); // Kiểm tra ngay trước khi gửi
                                    console.log("Kiểu dữ liệu messageToSend:", typeof messageToSend, messageToSend); // Kiểm tra kiểu dữ liệu
                                    console.log("Trước khi ghép chuỗi - currentRecipient:", currentRecipient, "Kiểu:", typeof currentRecipient);
                                    console.log("Trước khi ghép chuỗi - message:", message, "Kiểu:", typeof message);

                                    // Đảm bảo messageToSend là chuỗi hợp lệ
                                    if (typeof messageToSend !== "string" || messageToSend.trim() === "") {
                                        console.error("messageToSend không hợp lệ:", messageToSend);
                                        alert("Có lỗi khi gửi tin nhắn. Vui lòng thử lại. messageToSend: " + messageToSend);
                                        return;
                                    }

                                    socket.send(messageToSend);

                                    let messagesDiv = document.getElementById("messages");
                                    let messageElem = document.createElement("div"); // Tạo một element div
                                    messageElem.textContent = "Bạn: " + message; // Hiển thị đúng nội dung tin nhắn
                                    messagesDiv.appendChild(messageElem); // Thêm element vào messages
                                    messagesDiv.scrollTop = messagesDiv.scrollHeight;

                                    // Xóa nội dung input bằng inputElem
                                    document.getElementById("message-input").value = ""; // Sử dụng inputElem để xóa nội dung
                                }
        </script>

    </body>
</html>





