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
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
        <style>
            body {
                max-width: 1400px;
                font-family: 'Arial', sans-serif; /* Font đơn giản, chuyên nghiệp */
                margin: 0;
                padding: 0;
                height: 95vh;
                display: flex;
                background-color: #ffffff; /* Màu nền trắng giống Techcombank */
                overflow: hidden;
                padding-top: 40px; /* Khoảng cách để header không đè lên nội dung */
                background-color: #ffffff; /* Đảm bảo màu nền trắng */
                justify-content: center;
            }
            #user-list {
                width: 17%; /* Giữ độ rộng hợp lý để hiển thị danh sách */
                background-color: #ffffff; /* Màu nền trắng cho danh sách người dùng */
                border-right: 1px solid #e0e0e0; /* Đường viền nhẹ màu xám */
                border-top: 1px solid #e0e0e0;
                padding:10px;
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
                padding: 50px;
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
            input[type="email"] {
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

            input[type="email"]:focus {
                border-color: #d32f2f; /* Màu viền đỏ khi focus giống Techcombank */
            }
            input[type="date"] {
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

            input[type="date"]:focus {
                border-color: #d32f2f; /* Màu viền đỏ khi focus giống Techcombank */
            }
            select[type="text"] {
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

            select[type="text"]:focus {
                border-color: #d32f2f; /* Màu viền đỏ khi focus giống Techcombank */
            }
            input[type="tel"] {
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

            input[type="tel"]:focus {
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
            /* Định dạng header */
            /* Container chính cho toàn bộ nội dung trang */
            .page-container {
                max-width: 1200px; /* Giới hạn độ rộng tối đa, phù hợp với giao diện Techcombank */
                width: 100%;
                margin: 0 auto; /* Căn giữa toàn bộ nội dung trên trang */
                padding: 0 20px; /* Thêm padding bên trong để tạo khoảng cách với lề */
            }

            /* Định dạng header */
            header {
                width: 100%;
                background-color: #ffffff; /* Màu nền trắng giống Techcombank */
                padding: 10px 0; /* Loại bỏ padding bên trái/phải vì đã có trong .page-container */
                display: flex;
                justify-content: space-between; /* Căn đều các phần tử */
                align-items: center;
                position: fixed; /* Đặt header cố định trên cùng */
                top: 0;
                left: 0;
                z-index: 1000; /* Đảm bảo header nằm trên cùng */
            }
            header-container{
                display: flex;
            }

            /* Định dạng logo */
            .logo {
                cursor: pointer; /* Biểu tượng con trỏ tay khi hover */
            }

            .logo img {
                height: 40px; /* Kích thước logo giống Techcombank */
            }

            /* Định dạng menu điều hướng */
            .nav-menu {
                display: flex;
                gap: 20px; /* Khoảng cách giữa các mục menu */
            }

            .nav-menu a {
                text-decoration: none;
                color: #333333; /* Màu chữ xám đậm */
                font-size: 16px;
                font-weight: 500;
                text-transform: uppercase; /* Chữ in hoa giống Techcombank */
                transition: color 0.2s ease;
                margin-top: 9px;
            }

            .nav-menu a:hover {
                color: #d32f2f; /* Màu đỏ khi hover giống Techcombank */
            }

            /* Định dạng nút trong header */
            .header-button {
                padding: 8px 20px;
                background-color: #d32f2f; /* Màu đỏ giống Techcombank */
                color: white;
                border: none;
                border-radius: 20px; /* Bo góc tròn */
                cursor: pointer;
                font-size: 14px;
                font-weight: 600;
                text-transform: uppercase; /* Chữ in hoa */
                transition: background-color 0.2s ease;
            }

            .header-button:hover {
                background-color: #b71c1c; /* Màu đỏ đậm hơn khi hover */
            }

            /* Điều chỉnh phần user-list và chat-box để đồng bộ với khoảng cách lề */
            #user-list, #chat-box {
                margin: 0; /* Loại bỏ margin mặc định để dùng margin từ .page-container */
            }

            /* Đặt user-list và chat-box trong page-container */
            body > #user-list, body > #chat-box {
                margin-top: 20px; /* Khoảng cách từ header xuống nội dung */
            }
            /*            
                                    #user-list {
                                        width: 17%;  Giữ độ rộng hợp lý để hiển thị danh sách 
                                        background-color: #ffffff;  Màu nền trắng cho danh sách người dùng 
                                        border-right: 1px solid #e0e0e0;  Đường viền nhẹ màu xám 
                                        padding: 15px;
                                        box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);  Đổ bóng nhẹ 
                                        overflow-y: auto;
                                        max-height: 100vh;
                                    }
                        
                                    #chat-box {
                                        flex: 1;
                                        display: flex;
                                        flex-direction: column;
                                        background-color: #ffffff;  Màu nền trắng cho khung chat 
                                        box-shadow: -2px 0 5px rgba(0, 0, 0, 0.1);  Đổ bóng nhẹ 
                                        padding: 20px;
                                    }*/
            .header-container {
                max-width: 1400px; /* Giới hạn độ rộng tối đa, phù hợp với giao diện Techcombank */
                width: 100%;
                margin: 0 auto; /* Căn giữa header trên trang */
                padding: 0 20px; /* Thêm padding bên trong để tạo khoảng cách với lề */
                display: flex;
                justify-content: space-between;
            }
            #addAccount{
                margin-top: 60px;
                margin-right: 20px
            }
        </style>
    </head>
    <body>
        <header>
            <div class="header-container">
                <div class="logo" onclick="location.href = '/home'">
                    <img src="assets\images\logo-light.png" alt="Techcombank Logo">
                </div>

                <!-- Menu điều hướng -->
                <div class="nav-menu">
                    <a href="/news">Bảng tin</a>
                    <a href="/rates">Tỷ giá</a>
                    <a href="/forms">Biểu phí & Biểu mẫu</a>
                    <a href="/interest">Lãi suất</a>
                    <a href="/payment">Chứng thư bảo lãnh</a>
                    <a href="/bills">Hóa đơn điện tử</a>
                </div>
                <div class="header-controls">
                    <c:choose>
                        <c:when test="${sessionScope.sustomer == null && sessionScope.staff == null}">
                            <button class="header-button" onclick="location.href = '${pageContext.request.contextPath}/auth/template/login.jsp'">Đăng nhập</button>
                        </c:when>
                        <c:otherwise>
                            <button class="header-button" onclick="location.href = 'logout'">Đăng xuất</button>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </header>
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
        <div id="chat-box">
            <h2>SmartBank Support - Chat System</h2>
            <h3 id="chat-with">Chưa chọn người để chat</h3>
            <div id="messages"></div>
            <div class="flex">
                <input type="text" id="message-input" placeholder="Nhập tin nhắn...">
                <input type="file" id="file-input" style="display: none;">
                <!--                <button id="upload-button" onclick="triggerFileUpload()">Upload Ảnh</button>-->
                <button onclick="sendMessage()">Gửi</button>
            </div>
        </div>
        <c:if test="${sessionScope.staff.roleId.id == 2}">
            <form id="addAccount"class="mt-4 form-create-account" action="OnlineSupport" method="post">
                <div class="container">
                    <input value="add" type="hidden" name="add">
                    <div class="form-header">
                        <h2 id="chat-with">Thêm mới Account</h2>
                    </div>
                    <div class="col-md-12">
                        <div class="mb-3">
                            <label class="form-label">Username <span class="text-danger">*</span></label>
                            <input type="text" class="form-control username" placeholder="Username" name="username" required="">
                            <small class="text-danger usernameError" style="display: none;">Username không được chứa space hoặc kí tự đặc biệt.</small>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="mb-3">                                               
                            <label class="form-label">First name <span class="text-danger">*</span></label>
                            <input type="text" class="form-control firstname" placeholder="First Name" name="firstname" required="">
                            <small class="text-danger firstnameError" style="display: none;">First name không được chứa số và kí tự được biệt</small>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="mb-3">                                                 
                            <label class="form-label">Last name <span class="text-danger">*</span></label>
                            <input type="text" class="form-control lastname" placeholder="Last Name" name="lastname" required="">
                            <small class="text-danger lastnameError" style="display: none;">Last name không được chứa số và kí tự được biệt</small>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="mb-3">
                            <label class="form-label">Your Email <span class="text-danger">*</span></label>
                            <input type="email" id="email" class="form-control email" name="email" placeholder="Email" required="">
                            <small class="text-danger emailError" style="display: none;">Email không đúng format</small>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="mb-3">
                            <label class="form-label">Day of birth <span class="text-danger">*</span></label>
                            <input type="date" class="form-control dob" name="dob" required="">
                            <small class="dobError text-danger" style="display: none;">Customer phải ít nhất 18 tuổi trở lên.</small>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="mb-3">
                            <label class="form-label">Gender <span class="text-danger">*    </span></label>
                            <select type="text" class="form-control" name="gender" required="">
                                <option value="Male">Male</option>
                                <option value="Female">Female</option>
                            </select>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="mb-3">
                            <label class="form-label">Address <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" placeholder="Address" name="address" required="">
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="mb-3">
                            <label class="form-label">Phone Number <span class="text-danger">*</span></label>
                            <input type="tel" class="form-control phone" name="phone" placeholder="Enter phone number" required="" pattern="0[1-9]\d{7,8}" title="">
                            <small class="text-danger phoneError" style="display: none;">Vui lòng nhập đúng format số điện thoại (9-10 số và không kí tự đặc biệt)</small>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <div class="">
                            <button type="submit" class="btn btn-primary w-100">CREATE</button>
                        </div>
                    </div>
                </div>
            </form>
        </c:if>
        <script>
            let badWords = [];

            fetch("http://localhost:9999/BankingSystem/ChatFilter", {
                method: "GET",
                headers: {
                    "Content-Type": "application/json"
                }
            })
                    .then(response => {
                        if (!response.ok) {
                            throw new Error("Network response was not ok");
                        }
                        return response.json();
                    })
                    .then(data => {
                        badWords = data; // Lưu danh sách từ cấm
                        console.log("Bad words loaded:", badWords);
                    })
                    .catch(error => {
                        console.error("Error loading bad words:", error);
                    });

            function filterBadWords(text) {
                let filteredText = text;
                badWords.forEach(word => {
                    const regex = new RegExp("(?<!\\w)" + word + "(?!\\w)", "gi");
                    filteredText = filteredText.replace(regex, "*".repeat(word.length));
                });
                return filteredText;
            }
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
                                let imageData = chatMessage.replace("IMAGE", "").trim() + ":" + img;
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

                const filteredMessage = filterBadWords(message);

                let messageToSend = currentRecipient.trim() + ": " + filteredMessage;
                console.log("Sau khi ghép chuỗi - messageToSend:", messageToSend, "Kiểu:", typeof messageToSend);
                console.log("Gửi tin nhắn (trước gửi):", messageToSend);
                console.log("Kiểu dữ liệu messageToSend:", typeof messageToSend, messageToSend);
                console.log("Trước khi ghép chuỗi - currentRecipient:", currentRecipient, "Kiểu:", typeof currentRecipient);
                console.log("Trước khi ghép chuỗi - message:", filteredMessage, "Kiểu:", typeof filteredMessage);

                // Đảm bảo messageToSend là chuỗi hợp lệ
                if (typeof messageToSend !== "string" || messageToSend.trim() === "") {
                    console.error("messageToSend không hợp lệ:", messageToSend);
                    alert("Có lỗi khi gửi tin nhắn. Vui lòng thử lại. messageToSend: " + messageToSend);
                    return;
                }

                socket.send(messageToSend);

                let messagesDiv = document.getElementById("messages");
                let messageElem = document.createElement("div"); // Tạo một element div
                messageElem.textContent = "Bạn: " + filteredMessage; // Hiển thị đúng nội dung tin nhắn
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

        <script>
            document.querySelectorAll(".form-create-account, .form-update-account, .form-search-account").forEach(function (form) {
                // Username Validation
                form.querySelectorAll(".username").forEach(function (input) {
                    input.addEventListener("input", function () {
                        const username = this.value;
                        const usernamePattern = /^[\p{L}0-9]+$/u;
                        const errorMsg = form.querySelector(".usernameError");

                        if (!usernamePattern.test(username)) {
                            errorMsg.style.display = "block";
                            this.setCustomValidity("Username must not contain spaces or special characters.");
                        } else {
                            errorMsg.style.display = "none";
                            this.setCustomValidity("");
                        }
                    });
                });

                // First Name Validation
                form.querySelectorAll(".firstname").forEach(function (input) {
                    input.addEventListener("input", function () {
                        const firstname = this.value;
                        const namePattern = /^[\p{L}0-9]+$/u;
                        const errorMsg = form.querySelector(".firstnameError");

                        if (!namePattern.test(firstname)) {
                            errorMsg.style.display = "block";
                            this.setCustomValidity("First name must only contain letters.");
                        } else {
                            errorMsg.style.display = "none";
                            this.setCustomValidity("");
                        }
                    });
                });

                // Last Name Validation
                form.querySelectorAll(".lastname").forEach(function (input) {
                    input.addEventListener("input", function () {
                        const lastname = this.value;
                        const namePattern = /^[\p{L}0-9]+$/u;
                        const errorMsg = form.querySelector(".lastnameError");

                        if (!namePattern.test(lastname)) {
                            errorMsg.style.display = "block";
                            this.setCustomValidity("Last name must only contain letters.");
                        } else {
                            errorMsg.style.display = "none";
                            this.setCustomValidity("");
                        }
                    });
                });

                // Phone Validation
                form.querySelectorAll(".phone").forEach(function (input) {
                    input.addEventListener("input", function () {
                        let phoneInput = this.value;
                        let phonePattern = /^0[1-9]\d{7,8}$/;
                        let errorMsg = form.querySelector(".phoneError");

                        if (phonePattern.test(phoneInput)) {
                            this.setCustomValidity("");
                            errorMsg.style.display = "none";
                        } else {
                            this.setCustomValidity("Phone number không đúng format");
                            errorMsg.style.display = "block";
                        }
                    });
                });

                // Email Validation
                form.querySelectorAll(".email").forEach(function (input) {
                    input.addEventListener("input", function () {
                        let email = this.value;
                        let emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
                        let errorMsg = form.querySelector(".emailError");

                        if (emailPattern.test(email)) {
                            this.setCustomValidity(""); // ✅ Allow form submission
                            errorMsg.style.display = "none"; // ✅ Hide error message
                        } else {
                            this.setCustomValidity("Email không đúng format"); // ❌ Prevent form submission
                            errorMsg.style.display = "block"; // ❌ Show error message
                        }
                    });
                });
                form.querySelectorAll(".dob").forEach(function (input) {
                    input.addEventListener("change", function () {
                        const dobInput = this.value;
                        const dobError = form.querySelector(".dobError");

                        if (dobInput) {
                            const dob = new Date(dobInput);
                            const today = new Date();
                            const age = today.getFullYear() - dob.getFullYear();
                            const monthDiff = today.getMonth() - dob.getMonth();
                            const dayDiff = today.getDate() - dob.getDate();

                            const actualAge = (monthDiff < 0 || (monthDiff === 0 && dayDiff < 0)) ? age - 1 : age;

                            if (actualAge < 18) {
                                dobError.style.display = "block";
                                this.setCustomValidity("You must be at least 18 years old.");
                            } else {
                                dobError.style.display = "none";
                                this.setCustomValidity("");
                            }
                        }
                    });
                });
            });
            form.querySelectorAll(".password").forEach(function (input) {
                input.addEventListener("input", function () {
                    const password = this.value;
                    const passwordPattern = /^[A-Z](?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{7,}$/;
                    const errorMsg = form.querySelector(".passwordError");

                    if (passwordPattern.test(password)) {
                        this.setCustomValidity("");
                        errorMsg.style.display = "none";
                    } else {
                        this.setCustomValidity("Password must be at least 8 characters long, start with an uppercase letter, include at least one number, and one special character.");
                        errorMsg.style.display = "block";
                    }
                });
            });
        </script>
        <script>
            $(document).ready(function () {
                $(".form-create-account").submit(function (event) {
                    event.preventDefault();

                    var formData = new FormData(this);

                    $.ajax({
                        url: "OnlineSupport",
                        type: "POST",
                        data: formData,
                        processData: false,
                        contentType: false,
                        success: function (response) {
                            console.log("Response từ backend:", response);
                            if (response.trim() === "errorPhoneExist") {
                                alert("Số điện thoại đã có người sử dụng, vui lòng nhập số điện thoại khác.");
                            } else if (response.trim() === "errorEmailexist") {
                                alert("Email đã có người sử dụng, vui lòng nhập email khác.");
                            } else {
                                alert("Tạo tài khoản thành công!");
                                document.getElementById("addAccount").reset();
                            }
                        },
                        error: function () {
                            alert("Có lỗi xảy ra, vui lòng thử lại.");
                        }
                    });
                });
            });
        </script>

    </body>
</html>





