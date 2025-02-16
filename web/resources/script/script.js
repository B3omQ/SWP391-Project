/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

/* global toastr */

//function validatePassword() {
//    // Get password and confirm password values
//    const password = document.getElementById('password').value;
//    const confirmPassword = document.getElementById('confirmPassword').value;
//
//    // Check if passwords match
//    if (password !== confirmPassword) {
//        // Show error message and prevent form submission
//        document.getElementById('errorMessage').style.display = 'block';
//        return false; // Prevent form submission
//    }
//    // If passwords match, hide error message (just in case it was previously shown)
//    document.getElementById('errorMessage').style.display = 'none';
//    return true; // Allow form submission
//}

function onChangeSubmit(formId) {
    document.getElementById(formId).submit();
}

//function deleteAlert(event) {
//    if (window.confirm("Do you want to delete this entry?")) {
//        return true;
//    } else {
//        event.preventDefault();
//        return false;
//    }
//}


// Config toastr để bắn lỗi pop up
toastr.options = {
    closeButton: true,
    progressBar: true,
    positionClass: "toast-top-right",
    timeOut: "2000"
};

// Hàm tiện ích để hiển thị thông báo thành công
function showSuccessMessage(title, message) {
    toastr.success(message, title);
}

// Hàm tiện ích để hiển thị thông báo lỗi
function showErrorMessage(title, message) {
    toastr.error(message, title);
}

// Hàm tiện ích để hiển thị thông báo cảnh báo
function showWarningMessage(title, message) {
    toastr.warning(message, title);
}

// Hàm tiện ích để hiển thị thông báo thông tin
function showInfoMessage(title, message) {
    toastr.info(message, title);
}

// Hàm bắn notifi toastr sau khi reload trang
function reloadWithMessage(type, title, message) {
    localStorage.setItem("toastType", type);    // Lưu loại thông báo (success, error, warning, info)
    localStorage.setItem("toastTitle", title);  // Lưu tiêu đề thông báo
    localStorage.setItem("toastMessage", message); // Lưu nội dung thông báo
    location.reload(); // Reload trang ngay lập tức
}

function showToastrAfterReload() {
    let type = localStorage.getItem("toastType");
    let title = localStorage.getItem("toastTitle");
    let message = localStorage.getItem("toastMessage");

    if (type && message) {
        if (type === "success") {
            showSuccessMessage(title, message);
        } else if (type === "error") {
            showErrorMessage(title, message);
        } else if (type === "warning") {
            showWarningMessage(title, message);
        } else if (type === "info") {
            showInfoMessage(title, message);
        }

        // Xóa dữ liệu sau khi hiển thị để tránh lặp lại
        localStorage.removeItem("toastType");
        localStorage.removeItem("toastTitle");
        localStorage.removeItem("toastMessage");
    }
}


//// validate name: nếu có 2 dấu cách trở lên giữa 2 chữ thì báo lỗi, có dấu cách cuối tên báo lỗi
//function validateName(name) {
//    const doubleSpace = /\s{2,}/;
//    const trailingSpace = /\s$/;
//    const specialCharacters = /[^a-zA-Z\s]/;
//    if (doubleSpace.test(name)) {
//        showErrorMessage("Error", "Tên của bạn không hợp lệ");
//    }
//    if (trailingSpace.test(name)) {
//        showErrorMessage("Error", "Tên của bạn không hợp lệ");
//    }
//    if (specialCharacters.test(name)) {
//        showErrorMessage("Error", "Tên của bạn không hợp lệ");
//    }
//    return true;
//}
//
//// validate phone number: chỉ gồm các con số từ 10-11
//function validatePhoneNumber(phoneNumber) {
//    const phonePattern = /^\d{10,11}$/;
//    if (!phonePattern.test(phoneNumber)) {
//        showErrorMessage("Error", "Số điện thoại không hợp lệ");
//    }
//    return true;
//}
//
//// validate image: chỉ nhận các file có đuôi .jpg, .jpeg, .png
//function validateImage(file) {
//    const validExtensions = [".jpg", ".jpeg", ".png"];
//    const fileExtension = file.name.slice(file.name.lastIndexOf('.')).toLowerCase();
//    if (!validExtensions.includes(fileExtension)) {
//        showErrorMessage("Error", "Chỉ chấp nhận các file có đuôi jpg, jpeg, png");
//    }
//    return true;
//}
//
//// validate email: chuẩn theo quy định của email
//function validateEmail(email) {
//    const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
//    if (!emailPattern.test(email)) {
//        showErrorMessage("Error", "Email không hợp lệ");
//    }
//    return true;
//}

// For TinyMCE editor


