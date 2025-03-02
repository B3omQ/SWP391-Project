<!DOCTYPE html>
<!--
Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Html.html to edit this template
-->

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>SmartBank Chat</title>
        <style>
            body {
                font-family: 'Arial', sans-serif; /* Font đơn giản, chuyên nghiệp */
                margin: 0;
                padding: 0;
                height: 100vh;
                display: flex;
                background-color: #ffffff; /* Màu nền trắng giống Techcombank */
                overflow: hidden;
            }

            #user-list {
                width: 17%; /* Giữ độ rộng hợp lý để hiển thị danh sách */
                background-color: #ffffff; /* Màu nền trắng cho danh sách người dùng */
                border-right: 1px solid #e0e0e0; /* Đường viền nhẹ màu xám */
                padding: 15px;
                box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1); /* Đổ bóng nhẹ */
                overflow-y: auto;
                max-height: 100vh;
            }

            #user-list h3 {
                font-size: 16px;
                color: #d32f2f; /* Màu đỏ giống logo Techcombank */
                margin: 0 0 15px 0;
                font-weight: 600;
                text-transform: uppercase; /* Chữ in hoa giống Techcombank */
            }

            .user-item {
                cursor: pointer;
                padding: 12px 15px; /* Tăng padding để trông giống nút bấm hơn */
                border: 1px solid #d32f2f; /* Đường viền đỏ giống Techcombank */
                border-radius: 20px; /* Bo góc tròn giống nút bấm */
                background-color: #ffffff; /* Màu nền trắng khi không hover */
                color: #d32f2f; /* Màu chữ đỏ */
                font-weight: 600; /* Chữ đậm hơn giống nút */
                text-align: center; /* Căn giữa văn bản */
                margin-bottom: 10px; /* Khoảng cách giữa các nút */
                transition: all 0.3s ease; /* Hiệu ứng mượt mà cho hover */
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); /* Đổ bóng nhẹ để trông nổi hơn */
                list-style: none; /* Loại bỏ dấu chấm mặc định của li */
                display: block; /* Đảm bảo hiển thị như một khối */
            }

            .user-item:hover {
                background-color: #d32f2f; /* Màu nền đỏ khi hover */
                color: #ffffff; /* Màu chữ trắng khi hover */
                border-color: #b71c1c; /* Đường viền đỏ đậm hơn khi hover */
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* Đổ bóng đậm hơn khi hover */
            }

            .user-item.active {
                background-color: #d32f2f; /* Màu đỏ khi người dùng được chọn */
                color: #ffffff; /* Chữ trắng khi được chọn */
                border-color: #b71c1c; /* Đường viền đỏ đậm khi được chọn */
            }

            #chat-box {
                flex: 1;
                display: flex;
                flex-direction: column;
                background-color: #ffffff; /* Màu nền trắng cho khung chat */
                box-shadow: -2px 0 5px rgba(0, 0, 0, 0.1); /* Đổ bóng nhẹ */
                padding: 20px;
            }

            #chat-box h2 {
                font-size: 20px;
                color: #d32f2f; /* Màu đỏ giống Techcombank */
                margin: 0 0 10px 0;
                font-weight: 600;
                text-transform: uppercase; /* Chữ in hoa */
            }

            #chat-box h3 {
                font-size: 14px;
                color: #666666; /* Màu xám nhạt cho tiêu đề */
                margin: 0 0 15px 0;
                font-weight: 400;
            }

            #messages {
                flex: 1;
                padding: 15px;
                background-color: #f8f8f8; /* Màu nền nhạt giống Techcombank */
                border-radius: 6px; /* Bo góc nhẹ */
                overflow-y: auto;
                margin-bottom: 15px;
                margin-right: 100px; 
                box-shadow: inset 0 0 5px rgba(0, 0, 0, 0.05); /* Đổ bóng nhẹ bên trong */
            }

            /* Định dạng tin nhắn giống Techcombank (tin nhắn của người gửi và người nhận) */
            #messages div {
                margin: 5px 0;
                padding: 10px;
                border-radius: 6px; /* Bo góc nhẹ */
                max-width: 70%; /* Giới hạn độ rộng tin nhắn */
                word-wrap: break-word; /* Chuyển dòng tự động */
            }

            /* Tin nhắn của người gửi (Bạn) hiển thị bên phải, màu đỏ */
            #messages div:nth-child(odd) {
                background-color: #d32f2f; /* Màu đỏ giống Techcombank */
                color: white;
                margin-left: 0;
                margin-right: auto;
            }

            /* Tin nhắn của người nhận hiển thị bên trái, màu xám nhạt */
            #messages div:nth-child(even) {
                background-color: #e0e0e0; /* Màu xám nhạt */
                color: #333333; /* Màu chữ đen đậm */
                margin-left: 0;
                margin-right: auto;
            }

            /* Định dạng hình ảnh trong tin nhắn */
            #messages img {
                border-radius: 6px; /* Bo góc giống tin nhắn */
                max-width: 100%; /* Giới hạn kích thước ảnh */
                margin: 5px 0; /* Khoảng cách giống tin nhắn */
            }

            input[type="text"] {
                width: 60%;
                padding: 10px;
                border: 1px solid #e0e0e0; /* Đường viền xám nhẹ */
                border-radius: 25px; /* Bo góc tròn hơn, giống hình ảnh */
                font-size: 14px;
                margin-right: 10px;
                outline: none;
                transition: border-color 0.2s ease;
                background-color: #ffffff; /* Màu nền trắng */
                color: #333333; /* Màu chữ đen */
            }

            input[type="text"]:focus {
                border-color: #d32f2f; /* Màu viền đỏ khi focus giống Techcombank */
            }

            #upload-button, button {
                padding: 10px 50px;
                background-color: #d32f2f; /* Màu đỏ giống Techcombank */
                color: white;
                border: none;
                border-radius: 25px; /* Bo góc tròn hơn, giống hình ảnh */
                cursor: pointer;
                font-size: 14px;
                transition: background-color 0.2s ease;
                margin-right: 10px;
            }

            #upload-button:hover, button:hover {
                background-color: #b71c1c; /* Màu đỏ đậm hơn khi hover */
            }

            input[type="file"] {
                display: none; /* Ẩn input file */
            }
        </style>
    </head>
    <body>

        <!-- Danh sách người dùng online -->
        <div id="user-list">
            <c:if test="${sessionScope.staff == null}">
                <h3>Consultant online</h3>
            </c:if>
            <c:if test="${sessionScope.staff.roleId.id == 2}">
                <h3>Guess và customer đang truy cập</h3>
            </c:if>
            <ul id="online-users"></ul>
        </div>

        <!-- Hộp chat -->
        <div id="chat-box">
            <h2>SmartBank Support - Chat System</h2>
            <h3 id="chat-with">Chưa chọn người để chat</h3>
            <div id="messages"></div>
            <div class="flex">
            <input type="text" id="message-input" placeholder="Nhập tin nhắn...">
            <input type="file" id="file-input" style="display: none;">
            <button id="upload-button" onclick="triggerFileUpload()">Upload Ảnh</button>
            <button onclick="sendMessage()">Gửi</button>
            </div>
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
                    let messageElem;
                    if (event.data.includes(":")) {
                        const [sender, chatMessage, img] = event.data.split(":", 3);
                        if (chatMessage && chatMessage.trim() !== "") {
                            if (chatMessage.includes("IMAGE")) {
                                // Hiển thị ảnh cho cả sender và receiver
                                messageElem = document.createElement("img");
                                console.log("Tin nhắn từ server:", chatMessage);
                                let imageData = chatMessage.replace("IMAGE", "").trim() +":"+ img;
                                console.log("data ảnh:", imageData);
                                // Kiểm tra dữ liệu base64 chi tiết hơn
                                if (imageData && imageData.startsWith("data:image/")) {
                                    messageElem.src = imageData;
                                } else {
                                    console.error("Dữ liệu base64 không hợp lệ!");
                                }
//                                 else {
//                                    // Nếu dữ liệu không hợp lệ, hiển thị thông báo lỗi và log chi tiết
//                                    messageElem = document.createElement("div");
//                                    messageElem.innerText = sender.trim() + ": [Lỗi hiển thị ảnh: " + imageData + "]";
//                                    console.error("Dữ liệu ảnh không hợp lệ - Nhan:", imageData);
//                                }
                                messageElem.style.maxWidth = "100px";
                                messageElem.style.borderRadius = "6px";
                                messageElem.style.margin = "5px 0";
                            } else {
                                // Hiển thị tin nhắn văn bản
                                messageElem = document.createElement("div");
                                messageElem.innerText = sender.trim() + ": " + chatMessage.trim();
                            }
                        } else {
                            messageElem = document.createElement("div");
                            messageElem.innerText = event.data; // Hiển thị thông báo hệ thống nếu cần
                        }
                    } else {
                        messageElem = document.createElement("div");
                        messageElem.innerText = event.data; // Hiển thị thông báo hệ thống
                    }
                    messagesDiv.appendChild(messageElem);
                    messagesDiv.scrollTop = messagesDiv.scrollHeight;
                }
            };

            // Hàm kiểm tra dữ liệu base64 có phải là hình ảnh hợp lệ không (cải tiến)
            function isValidBase64Image(data) {
                try {
                    // Kiểm tra nếu dữ liệu là base64 nguyên bản (không có prefix data:image/)
                    const base64Test = /^([A-Za-z0-9+/]+={0,2})$/;
                    if (data.startsWith("data:image/")) {
                        return true; // Nếu đã có prefix data:image, coi là hợp lệ
                    } else if (base64Test.test(data)) {
                        // Nếu là base64 nguyên bản, thử tạo một image object để kiểm tra
                        const img = new Image();
                        img.src = `data:image/jpeg;base64,${data}`;
                        return new Promise(resolve => {
                            img.onload = () => resolve(true);
                            img.onerror = () => resolve(false);
                            // Đặt timeout để tránh treo nếu ảnh không hợp lệ
                            setTimeout(() => resolve(false), 1000); // Timeout sau 1 giây
                        });
                    }
                    return false;
                } catch (e) {
                    console.error("Lỗi kiểm tra base64:", e);
                    return false;
                }
            }

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

            // Hàm kích hoạt input file khi nhấn nút "Upload Ảnh"
            function triggerFileUpload() {
                document.getElementById("file-input").click();
            }

            // Hàm xử lý khi chọn file ảnh từ máy
            document.getElementById("file-input").addEventListener("change", function (e) {
                const file = e.target.files[0];
                if (file && file.type.startsWith("image/")) {
                    const reader = new FileReader();
                    reader.onload = function (e) {
                        const imageData = e.target.result; // Dữ liệu base64 của ảnh
                        console.log("Dữ liệu ảnh từ FileReader:", imageData);
                        sendImage(imageData);
                    };
                    reader.readAsDataURL(file); // Đọc file ảnh dưới dạng base64
                } else {
                    alert("Vui lòng chọn một file ảnh hợp lệ.");
                }
            });

            // Hàm xử lý paste ảnh từ clipboard
            document.getElementById("message-input").addEventListener("paste", function (e) {
                const items = (e.clipboardData || e.originalEvent.clipboardData).items;
                for (let i = 0; i < items.length; i++) {
                    if (items[i].type.startsWith("image/")) {
                        const file = items[i].getAsFile();
                        const reader = new FileReader();
                        reader.onload = function (e) {
                            const imageData = e.target.result; // Dữ liệu base64 của ảnh
                            console.log("Dữ liệu ảnh từ Clipboard:", imageData);
                            sendImage(imageData);
                        };
                        reader.readAsDataURL(file);
                        break; // Chỉ xử lý ảnh đầu tiên nếu có nhiều nội dung trong clipboard
                    }
                }
            });

            // Hàm gửi ảnh qua WebSocket
            function sendImage(imageData) {
                if (!currentRecipient || currentRecipient.trim() === "") {
                    alert("Vui lòng chọn người nhận từ danh sách online.");
                    return;
                }
                if (socket.readyState === WebSocket.OPEN) {
                    if (!imageData.startsWith("data:image/")) {
                        console.error("Dữ liệu ảnh không hợp lệ:", imageData);
                        alert("Dữ liệu ảnh không hợp lệ. Vui lòng thử lại.");
                        return;
                    }
                    // Kiểm tra dữ liệu base64 hợp lệ trước khi gửi
                    if (!isValidBase64Image(imageData.replace("data:image/jpeg;base64,", ""))) {
                        console.error("Dữ liệu base64 không hợp lệ:", imageData);
                        alert("Dữ liệu base64 không hợp lệ. Vui lòng thử lại.");
                        return;
                    }
                    const messageToSend = currentRecipient + ": " + "IMAGE" + imageData; // Định dạng tin nhắn ảnh
                    console.log("Gửi ảnh - messageToSend:", messageToSend);
                    socket.send(messageToSend);

                    const messagesDiv = document.getElementById("messages");
                    const imageElem = document.createElement("img");
                    imageElem.src = imageData;
                    imageElem.style.maxWidth = "200px"; // Giới hạn kích thước ảnh
                    imageElem.style.borderRadius = "6px"; // Bo góc giống tin nhắn
                    imageElem.style.margin = "5px 0"; // Khoảng cách giống tin nhắn
                    messagesDiv.appendChild(imageElem);
                    messagesDiv.scrollTop = messagesDiv.scrollHeight;
                } else {
                    alert("Kết nối WebSocket chưa sẵn sàng. Vui lòng thử lại.");
                }
            }
        </script>

    </body>
</html>





