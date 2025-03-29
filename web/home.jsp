<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="/template/header.jsp" %>

<!-- Start Hero -->
<section class="bg-half-260 d-table w-100" style="background: url('assets/images/bg/banner-home-pc') center;">
    <div class="bg-overlay bg-overlay-dark"></div>
    <div class="container">
        <div class="row mt-5 mt-lg-0">
            <div class="col-12">
                <div class="heading-title">
                    <img src="assets/images/logo-icon2.png" height="50" alt="">
                    <h4 class="display-4 fw-bold text-white title-dark mt-3 mb-4">
                        Trao niềm tin <br>Nhận tài Lộc SmartBank</h4>
                    <p class="para-desc text-white-50 mb-0">
                        Dịch vụ tuyệt vời nếu bạn cần một đối tác ngân hàng
                        đáng tin cậy để được hỗ trợ tài chính ngay lập tức,
                        giao dịch an toàn hoặc tư vấn quản lý tài khoản đơn giản.</p>

                    <div class="mt-4 pt-2">
                        <a href="OnlineSupport" class="btn btn-primary">Hỗ trợ tạo tài khoản ngay</a>
                        <p class="text-white-50 mb-0 mt-2">T&C apply. Vui lòng đọc 
                            <a href="#"class="text-white-50">Điều khoản và Điều kiện 
                                <i class="ri-arrow-right-line align-middle">

                                </i>
                            </a>
                        </p>
                    </div>
                </div>
            </div><!--end col-->
        </div><!--end row-->
    </div><!--end container-->
</section><!--end section-->
<!-- End Hero -->

<!-- Start -->
<section class="section">
    <div class="container wow fadeInUp">
        <div class="row justify-content-center">
            <div class="col-xl-10">
                <div class="features-absolute bg-white shadow rounded overflow-hidden card-group">
                    <div class="card border-0 bg-light p-4">
                        <i class="ri-tools-fill text-primary h2 mb-0"></i>
                        <h5 class="mt-1">Công Cụ Và Tiện Ích</h5>
                        <p class="text-muted mt-2">SmartBank cung cấp các công cụ hỗ trợ tài chính hiện đại như tính toán lãi suất,
                            quản lý chi tiêu và dự báo đầu tư. Giúp bạn kiểm soát tài chính hiệu quả mọi lúc, mọi nơi.</p>
                        <a href="departments.html" class="text-primary">Tìm Hiểu Thêm <i
                                class="ri-arrow-right-line align-middle"></i></a>
                    </div>

                    <div class="card border-0 p-4">
                        <i class="ri-bank-fill text-primary h2 mb-0"></i>
                        <h5 class="mt-1">Dịch Vụ Ngân Hàng</h5>
                        <p class="text-muted mt-2">Sử dụng các dịch vụ ngân hàng tiện lợi như gửi tiết kiệm,
                            vay vốn và đầu tư sinh lời với SmartBank. Giao dịch an toàn, nhanh chóng và tối ưu lợi nhuận cho khách hàng.</p>
                        <a href="departments.html" class="text-primary">Tìm Hiểu Thêm <i
                                class="ri-arrow-right-line align-middle"></i></a>
                    </div>

                    <div class="card border-0 bg-light p-4">
                        <i class="ri-time-fill text-primary h2 mb-0"></i>
                        <h5 class="mt-1">Giờ Hoạt Động Mở Tài Khoản Và Hỗ Trợ</h5>
                        <ul class="list-unstyled mt-2">
                            <li class="d-flex justify-content-between">
                                <p class="text-muted mb-0">Thứ Hai - Thứ Sáu</p>
                                <p class="text-primary mb-0">8.00 - 20.00</p>
                            </li>
                            <li class="d-flex justify-content-between">
                                <p class="text-muted mb-0">Thứ Bảy</p>
                                <p class="text-primary mb-0">8.00 - 18.00</p>
                            </li>
                            <li class="d-flex justify-content-between">
                                <p class="text-muted mb-0">Chủ Nhật</p>
                                <p class="text-primary mb-0">8.00 - 14.00</p>
                            </li>
                        </ul>
                        <!--                                <a href="departments.html" class="text-primary">Tìm hiểu Thêm <i
                                                                class="ri-arrow-right-line align-middle"></i></a>-->
                    </div>
                </div>
            </div><!--end col-->
        </div><!--end row-->
    </div><!--end container-->

    <div class="container mt-100 mt-60 wow fadeInUp">
        <div class="row align-items-center">
            <div class="col-lg-5 col-md-6">
                <div class="position-relative">
                    <img src="assets/images/about/about-1.png" class="img-fluid" alt="">
                    <!--                            <div class="play-icon">
                                                    <a href="#" data-bs-toggle="modal" data-bs-target="#watchvideomodal"
                                                       class="play-btn video-play-icon">
                                                        <i class="mdi mdi-play text-primary rounded-circle bg-white title-bg-dark shadow"></i>
                                                    </a>
                                                </div>-->
                </div>
            </div><!--end col-->

            <div class="col-lg-7 col-md-6 mt-4 mt-lg-0 pt- pt-lg-0">
                <div class="ms-lg-4">
                    <div class="section-title">
                        <h4 class="title mb-4">Về Ngân Hàng Của Chúng Tôi</h4>
                        <p class="text-muted para-desc">SmartBank là một hệ thống ngân hàng trực tuyến,
                            cung cấp các dịch vụ tài chính đa dạng bao gồm cho vay, gửi tiết kiệm và đầu tư.</p>
                        <p class="text-muted para-desc mb-0">Với giao diện thân thiện và các tính năng tiện ích, 
                            SmartBank giúp người dùng dễ dàng quản lý tài chính,
                            thực hiện giao dịch an toàn và tối ưu hóa lợi nhuận từ các khoản đầu tư.</p>
                    </div>

                    <!--                            <div class="mt-4">
                                                    <a href="aboutus.html" class="btn btn-primary">Tìm hiểu thêm <i
                                                            class="ri-arrow-right-line align-middle"></i></a>
                                                </div>-->
                </div>
            </div><!--end col-->
        </div><!--end row-->
    </div><!--end container-->

    <div class="container mt-100 mt-60 wow fadeInUp">
        <div class="row justify-content-center">
            <div class="col-12">
                <div class="section-title mb-4 pb-2 text-center">
                    <span class="badge badge-pill badge-soft-primary mb-3">Phòng Ban</span>
                    <h4 class="title mb-4">Dịch Vụ Ngân Hàng</h4>
                    <p class="text-muted mx-auto para-desc mb-0">Dịch vụ cho vay, gửi tiết kiệm và đầu tư, 
                        giúp khách hàng quản lý tài chính hiệu quả. Hệ thống đảm bảo giao dịch an toàn, nhanh chóng và tối ưu lợi nhuận.</p>
                </div>
            </div><!--end col-->
        </div><!--end row-->

        <div class="row">
            <div class="col-xl-3 col-md-4 col-12 mt-5">
                <div class="card features feature-primary border-0">
                    <div class="icon text-center rounded-md">
                        <i class="ri-bank-card-fill h3 mb-0"></i>
                    </div>
                    <div class="card-body p-0 mt-3">
                        <a href="${pageContext.request.contextPath}/customer/Saving.jsp" class="title text-dark h5">Gửi Tiết Kiệm</a>
                        <p class="text-muted mt-3">Tích lũy tài chính an toàn với các gói tiết kiệm linh hoạt,
                            lãi suất hấp dẫn và rút tiền dễ dàng.</p>
                        <a href="${pageContext.request.contextPath}/customer/Saving.jsp" class="link">Tìm Hiểu Thêm <i
                                class="ri-arrow-right-line align-middle"></i></a>
                    </div>
                </div>
            </div><!--end col-->

            <div class="col-xl-3 col-md-4 col-12 mt-5">
                <div class="card features feature-primary border-0">
                    <div class="icon text-center rounded-md">
                        <i class="ri-hand-coin-fill h3 mb-0"></i>
                    </div>
                    <div class="card-body p-0 mt-3">
                        <a href="${pageContext.request.contextPath}/applyLoan" class="title text-dark h5">Vay Tín Dụng</a>
                        <p class="text-muted mt-3">Giải pháp vay vốn nhanh chóng, thủ tục đơn giản, lãi suất ưu đãi.
                            Đáp ứng nhu cầu tài chính cá nhân và kinh doanh một cách thuận tiện nhất.</p>
                        <a href="${pageContext.request.contextPath}/applyLoan" class="link">Tìm Hiểu Thêm <i
                                class="ri-arrow-right-line align-middle"></i></a>
                    </div>
                </div>
            </div><!--end col-->

            <div class="col-xl-3 col-md-4 col-12 mt-5">
                <div class="card features feature-primary border-0">
                    <div class="icon text-center rounded-md">
                        <i class="ri-user-add-fill h3 mb-0"></i>
                    </div>
                    <div class="card-body p-0 mt-3">
                        <a href="${pageContext.request.contextPath}/OnlineSupport" class="title text-dark h5">Tạo Tài Khoản</a>
                        <p class="text-muted mt-3">Đăng ký tài khoản trực tuyến chỉ trong vài phút làm việc với nhân viên hỗ trợ 
                            để trải nghiệm các dịch vụ tài chính hiện đại,
                            an toàn và tiện lợi từ SmartBank.</p>
                        <a href="${pageContext.request.contextPath}/OnlineSupport" class="link">Tìm Hiểu Thêm <i
                                class="ri-arrow-right-line align-middle"></i></a>
                    </div>
                </div>
            </div><!--end col-->

            <div class="col-xl-3 col-md-4 col-12 mt-5">
                <div class="card features feature-primary border-0">
                    <div class="icon text-center rounded-md">
                        <i class="ri-bar-chart-fill h3 mb-0"></i>
                    </div>
                    <div class="card-body p-0 mt-3">
                        <a  class="title text-dark h5">Đầu tư</a>
                        <p class="text-muted mt-3">Tối ưu hóa lợi nhuận với các danh mục đầu tư đa dạng, phù hợp với mọi nhu cầu.
                            Quản lý danh mục thông minh và nhận tư vấn chiến lược đầu tư từ SmartBank.</p>
                        <a  class="link">Tìm Hiểu Thêm <i
                                class="ri-arrow-right-line align-middle"></i></a>
                    </div>
                </div>
            </div><!--end col-->
        </div><!--end row-->
    </div><!--end container-->
</section><!--end section-->
<!-- End -->

<!-- Start -->
<section class="section pt-0">
    <div class="container">
        <div class="row justify-content-center wow fadeInUp">
            <div class="col-12 text-center">
                <div class="video-solution-cta position-relative" style="z-index: 1;">
                    <div class="position-relative">
                        <img src="assets/images/bg/bg-home.jpeg" class="img-fluid rounded-md shadow-lg" alt="">
                    </div>

                    <div class="content">
                        <div class="row" id="counter">
                            <div class="col-md-4 mt-4 pt-2">
                                <div class="counter-box text-center">
                                    <h1 class="mt-3 text-white title-dark"><span class="counter-value"
                                                                                 data-target="99">10</span>%</h1>
                                    <h5 class="counter-head text-white title-dark mb-1">Phản hồi tích cực</h5>
                                    <p class="text-white-50 mb-0">Từ người dùng</p>
                                </div><!--end counter box-->
                            </div><!--end col-->

                            <div class="col-md-4 mt-4 pt-2">
                                <div class="counter-box text-center">
                                    <h1 class="mt-3 text-white title-dark"><span class="counter-value"
                                                                                 data-target="25">2</span>+</h1>
                                    <h5 class="counter-head text-white title-dark mb-1">Nhân viên có kinh nghiệm</h5>
                                    <p class="text-white-50 mb-0">Trình độ cao</p>
                                </div><!--end counter box-->
                            </div><!--end col-->

                            <div class="col-md-4 mt-4 pt-2">
                                <div class="counter-box text-center">
                                    <h1 class="mt-3 text-white title-dark"><span class="counter-value"
                                                                                 data-target="1251">95</span>+</h1>
                                    <h5 class="counter-head text-white title-dark mb-1">Câu hỏi & Phản hồi</h5>
                                    <p class="text-white-50 mb-0">Thắc mắc của bạn</p>
                                </div><!--end counter box-->
                            </div><!--end col-->
                        </div><!--end row-->
                    </div>
                </div>
            </div><!--end col-->
        </div><!--end row -->
        <div class="feature-posts-placeholder bg-primary"></div>
    </div><!--end container-->
</section><!--end section-->
<!-- End -->

<!-- Phần đánh giá khách hàng, tạo và lấy lên từ database, dưới là format fontend -->
<!-- Start -->
<section class="section">
    <div class="container">
        <div class="row justify-content-center wow fadeInUp">
            <div class="col-12">
                <div class="section-title text-center mb-4 pb-2">
                    <h4 class="title mb-4">Khách hàng nói về chúng tôi</h4>
                    <p class="text-muted mx-auto para-desc mb-0">Phản hồi về chất lượng của người dùng là nền móng để chúng tôi phát triển ngày một tốt hơn.</p>
                </div>
            </div><!--end col-->
        </div><!--end row-->
        <div class="row justify-content-center wow fadeInUp">
            <div class="col-lg-8 mt-4 pt-2 text-center">
                <div class="client-review-slider">
                    <c:forEach var="r" items="${rlist}">
                        <div class="tiny-slide text-center">
                            <p class="text-muted h6 fw-normal fst-italic">${r.review}</p>
                            <ul class="list-unstyled mb-0">
                                <c:forEach var="i" begin="1" end="5">
                                    <li class="list-inline-item">
                                        <i class="mdi mdi-star ${i <= r.rate ? 'text-warning' : 'text-secondary'}"></i>
                                    </li>
                                </c:forEach>
                            </ul>
                            <h6 class="text-primary">-${r.cusid.username}<small class="text-muted"></small></h6>
                        </div><!--end customer testi-->
                    </c:forEach>
                </div><!--end carousel-->
            </div><!--end col-->
        </div><!--end row-->
    </div><!--end container-->


    <!-- Phần News -->
    <div class="container mt-100 mt-60 wow fadeInUp">
        <div class="row justify-content-center">
            <div class="col-12">
                <div class="section-title text-center mb-4 pb-2">
                    <span class="badge badge-pill badge-soft-primary mb-3">Thông tin mới</span>
                    <h4 class="title mb-4">Khám phá và chia sẻ</h4>
                    <p class="text-muted mx-auto para-desc mb-0">Những thông tin, thông báo chính thức của SmartBank</p>
                </div>
            </div><!--end col-->
        </div><!--end row-->

        <div class="row justify-content-between">
            <c:forEach var="a" items="${alist}">
                <div class="col-lg-4 col-md-6 mb-4">
                    <div class="card testimonial-card">
                        <img src="${pageContext.request.contextPath}${a.imageUrl}" class="img-fluid" alt="">
                        <div class="card-body p-4">
                            <ul class="list-unstyled mb-2">
                                <li class="list-inline-item text-muted small me-3"><i
                                        class="uil uil-calendar-alt text-dark h6 me-1"></i><fmt:formatDate value="${a.publishDate}" pattern="yyyy-MM-dd"/></li>
                                <li class="list-inline-item text-muted small"><i
                                        class="uil uil-clock text-dark h6 me-1"></i>5 min read</li>
                            </ul>
                            <a href="${pageContext.request.contextPath}/NewsDetailServlet?id=${a.id}" class="text-dark title h5">${a.title}</a>
                            <div class="post-meta d-flex justify-content-between mt-3">
                                <a href="${pageContext.request.contextPath}/NewsDetailServlet?id=${a.id}" class="link">Read More <i
                                        class="mdi mdi-chevron-right align-middle"></i></a>
                            </div>
                        </div>
                    </div>
                </div><!--end col-->
            </c:forEach>
        </div><!--end row-->
    </div><!--end container-->
</section><!--end section-->
<!-- End -->
<!-- Partners start -->
<section class="py-4 bg-light">
    <div class="container">
        <div class="row justify-content-center wow fadeInUp">
            <div class="col-lg-2 col-md-2 col-6 text-center py-4">
                <img src="assets/images/client/amazon.png" class="avatar avatar-client" alt="">
            </div><!--end col-->

            <div class="col-lg-2 col-md-2 col-6 text-center py-4">
                <img src="assets/images/client/google.png" class="avatar avatar-client" alt="">
            </div><!--end col-->

            <div class="col-lg-2 col-md-2 col-6 text-center py-4">
                <img src="assets/images/client/lenovo.png" class="avatar avatar-client" alt="">
            </div><!--end col-->

            <div class="col-lg-2 col-md-2 col-6 text-center py-4">
                <img src="assets/images/client/paypal.png" class="avatar avatar-client" alt="">
            </div><!--end col-->

            <div class="col-lg-2 col-md-2 col-6 text-center py-4">
                <img src="assets/images/client/shopify.png" class="avatar avatar-client" alt="">
            </div><!--end col-->

            <div class="col-lg-2 col-md-2 col-6 text-center py-4">
                <img src="assets/images/client/spotify.png" class="avatar avatar-client" alt="">
            </div><!--end col-->
        </div><!--end row-->
    </div><!--end container-->
</section><!--end section-->
<!-- Partners End -->

<!-- Start -->
<footer class="bg-footer">
    <div class="container wow fadeInUp">
        <div class="row">
            <div class="col-xl-5 col-lg-4 mb-0 mb-md-4 pb-0 pb-md-2">
                <a href="#" class="logo-footer">
                    <img src="assets/images/logo-light.png" height="22" alt="">
                </a>
                <p class="mt-4 me-xl-5">SmartBank cung cấp các dịch vụ cho vay, gửi tiết kiệm và đầu tư,
                    giúp khách hàng quản lý tài chính hiệu quả. Hệ thống đảm bảo giao dịch an toàn, nhanh chóng và tối ưu lợi nhuận.</p>
            </div><!--end col-->

            <div class="col-xl-7 col-lg-8 col-md-12">
                <div class="row">
                    <div class="col-md-4 col-12 mt-4 mt-sm-0 pt-2 pt-sm-0">
                        <h5 class="text-light title-dark footer-head">Công ty</h5>
                        <ul class="list-unstyled footer-list mt-4">
                            <li><a href="aboutus.html" class="text-foot"><i class="mdi mdi-chevron-right me-1"></i>
                                    Về Chúng tôi</a></li>
                            <li><a href="departments.html" class="text-foot"><i
                                        class="mdi mdi-chevron-right me-1"></i> Dịch vụ</a></li>
                            <li><a href="doctor-team-two.html" class="text-foot"><i
                                        class="mdi mdi-chevron-right me-1"></i> Team</a></li>
                            <li><a href="blog-detail.html" class="text-foot"><i
                                        class="mdi mdi-chevron-right me-1"></i> Project</a></li>
                            <li><a href="blogs.html" class="text-foot"><i class="mdi mdi-chevron-right me-1"></i>
                                    Blog</a></li>
                            <li><a href="
                                   /login.jsp" class="text-foot"><i class="mdi mdi-chevron-right me-1"></i>
                                    Login</a></li>
                        </ul>
                    </div><!--end col-->

                    <div class="col-md-4 col-12 mt-4 mt-sm-0 pt-2 pt-sm-0">
                        <h5 class="text-light title-dark footer-head">Phòng Ban</h5>
                        <ul class="list-unstyled footer-list mt-4">
                            <li><a href="departments.html" class="text-foot"><i
                                        class="mdi mdi-chevron-right me-1"></i> Gửi Tiết Kiệm</a></li>
                            <li><a href="departments.html" class="text-foot"><i
                                        class="mdi mdi-chevron-right me-1"></i> Vay Tín Dụng</a></li>
                            <li><a href="departments.html" class="text-foot"><i
                                        class="mdi mdi-chevron-right me-1"></i> Tạo Tài Khoản</a></li>
                            <li><a href="departments.html" class="text-foot"><i
                                        class="mdi mdi-chevron-right me-1"></i> Đầu tư</a></li>

                        </ul>
                    </div><!--end col-->

                    <div class="col-md-4 col-12 mt-4 mt-sm-0 pt-2 pt-sm-0">
                        <h5 class="text-light title-dark footer-head">Liên hệ</h5>
                        <ul class="list-unstyled footer-list mt-4">
                            <li class="d-flex align-items-center">
                                <i data-feather="mail" class="fea icon-sm text-foot align-middle"></i>
                                <a href="mailto:dichvuhotrosmartbank@gmail.com
                                   " class="text-foot ms-2">dichvuhotrosmartbank@gmail.com
                                </a>
                            </li>

                            <li class="d-flex align-items-center">
                                <i data-feather="phone" class="fea icon-sm text-foot align-middle"></i>
                                <a href="tel:+152534-468-854" class="text-foot ms-2">+84 936-924-631</a>
                            </li>
                        </ul>

                        <ul class="list-unstyled social-icon footer-social mb-0 mt-4">
                            <li class="list-inline-item"><a href="#" class="rounded-pill"><i data-feather="facebook"
                                                                                             class="fea icon-sm fea-social"></i></a></li>
                            <li class="list-inline-item"><a href="#" class="rounded-pill"><i
                                        data-feather="instagram" class="fea icon-sm fea-social"></i></a></li>
                            <li class="list-inline-item"><a href="#" class="rounded-pill"><i data-feather="twitter"
                                                                                             class="fea icon-sm fea-social"></i></a></li>
                            <li class="list-inline-item"><a href="#" class="rounded-pill"><i data-feather="linkedin"
                                                                                             class="fea icon-sm fea-social"></i></a></li>
                        </ul><!--end icon-->
                    </div><!--end col-->
                </div><!--end row-->
            </div><!--end col-->
        </div><!--end row-->
    </div><!--end container-->

    <div class="container mt-5 wow fadeInUp">
        <div class="pt-4 footer-bar">
            <div class="row align-items-center">
                <div class="col-sm-6">
                    <div class="text-sm-start text-center">
                        <p class="mb-0">
                            <script>document.write(new Date().getFullYear())</script> Bản quyền © 2025 thuộc về Ngân hàng SmartBank <i
                                class="mdi mdi-heart text-danger"></i> bởi <a href="http://localhost:9999/BankingSystem/"
                                target="_blank" class="text-reset">Nhóm 2</a>.
                        </p>
                    </div>
                </div><!--end col-->

                <div class="col-sm-6 mt-4 mt-sm-0">
                    <ul class="list-unstyled footer-list text-sm-end text-center mb-0">
                        <li class="list-inline-item"><a href="terms.html" class="text-foot me-2">Điều khoản</a></li>
                        <li class="list-inline-item"><a href="privacy.html" class="text-foot me-2">Quyền riêng tư dữ liệu</a></li>
                        <li class="list-inline-item"><a href="contact.html" class="text-foot me-2">☎ KH doanh nghiệp</a></li>
                    </ul>
                </div><!--end col-->
            </div><!--end row-->
        </div>
    </div><!--end container-->
</footer><!--end footer-->
<!-- End -->
<div class="chat-icon" onclick="toggleChat()" >
    <img src="assets/images/ai logo/ai logo.png" class="avatar avatar-medium"/>
</div>
<div class="chat-container mb-5" id="chatContainer">
    <div class="chat-header">
        Chat cùng smartBank Digibot
        <button class="close-btn" onclick="toggleChat()">
            <img src="assets/images/ai logo/delete.png" alt="Đóng"> </button>
    </div>
    <div class="chat-box" id="chatBox"></div>
    <div class="loading" id="loading"></div>
    <div class="chat-input">
        <input type="text" id="userMessage" placeholder="Nhập tin nhắn..." onkeypress="handleKeyPress(event)">
        <button onclick="sendMessage()">Gửi</button>
    </div>
</div>
<script>
    function toggleChat() {
        const chatBox = document.getElementById("chatContainer");
        chatBox.style.display = (chatBox.style.display === "none" || chatBox.style.display === "") ? "block" : "none";
    }

    function handleKeyPress(event) {
        if (event.key === "Enter") {
            sendMessage();
        }
    }

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

    function sendMessage() {
        const userMessageInput = document.getElementById("userMessage");
        let userMessage = userMessageInput.value.trim();

        if (!userMessage) {
            return;
        }
        const filteredMessage = filterBadWords(userMessage);
        displayMessage(filteredMessage, true);
        console.log("Before filter:", userMessage, "After filter:", filteredMessage);
        userMessageInput.value = "";
        showLoadingIndicator(true);

        fetch("http://localhost:9999/BankingSystem/AiChatBotServlet", {
            method: "POST",
            headers: {"Content-Type": "application/x-www-form-urlencoded"},
            body: new URLSearchParams({message: filteredMessage})
        })
                .then(response => {
                    if (!response.ok) {
                        throw new Error("Network response was not ok");
                    }
                    return response.json();
                })
                .then(data => {
                    showLoadingIndicator(false);
                    if (data && data.reply) {
                        displayMessage(data.reply, false);
                    } else {
                        displayMessage("Lỗi: AI không phản hồi hoặc dữ liệu không hợp lệ.", false, "error");
                        console.error("Invalid AI response:", data);
                    }
                })
                .catch(error => {
                    showLoadingIndicator(false);
                    displayMessage("Lỗi: Không thể kết nối tới AI.", false, "error");
                    console.error("Error:", error);
                });
    }

    function displayMessage(message, isUser, messageType = "normal") {
        const chatBox = document.getElementById("chatBox");
        const messageElement = document.createElement("p");
        messageElement.classList.add(isUser ? "user-message" : "ai-message");
        if (messageType === "error") {
            messageElement.style.color = "red";
        }

        // Sử dụng innerHTML để hỗ trợ HTML trong tin nhắn
        messageElement.innerHTML = (isUser ? "Bạn: " : "Digibot: ") + message;
        chatBox.appendChild(messageElement);
        chatBox.scrollTop = chatBox.scrollHeight;
    }

    function showLoadingIndicator(show) {
        const loadingIndicator = document.getElementById("loading");
        loadingIndicator.style.display = show ? "block" : "none";
    }

</script>

<!-- Back to top -->
<a href="#" onclick="topFunction()" id="back-to-top" class="btn btn-icon btn-pills btn-primary back-to-top"><i
        data-feather="arrow-up" class="icons"></i></a>
<!-- Back to top -->

<!-- Offcanvas Start -->
<div class="offcanvas bg-white offcanvas-top" tabindex="-1" id="offcanvasTop">
    <div class="offcanvas-body d-flex align-items-center align-items-center">
        <div class="container">
            <div class="row">
                <div class="col">
                    <div class="text-center">
                        <h4>Search now.....</h4>
                        <div class="subcribe-form mt-4">
                            <form>
                                <div class="mb-0">
                                    <input type="text" id="help" name="name" class="border bg-white rounded-pill"
                                           required="" placeholder="Search">
                                    <button type="submit" class="btn btn-pills btn-primary">Search</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div><!--end col-->
            </div><!--end row-->
        </div><!--end container-->
    </div>
</div>
<!-- Offcanvas End -->

<!-- Offcanvas Start -->
<div class="offcanvas offcanvas-end bg-white shadow" tabindex="-1" id="offcanvasRight"
     aria-labelledby="offcanvasRightLabel">
    <div class="offcanvas-header p-4 border-bottom">
        <h5 id="offcanvasRightLabel" class="mb-0">
            <img src="assets/images/logo-dark.png" height="24" class="light-version" alt="">
            <img src="assets/images/logo-light.png" height="24" class="dark-version" alt="">
        </h5>
        <button type="button" class="btn-close d-flex align-items-center text-dark" data-bs-dismiss="offcanvas"
                aria-label="Close"><i class="uil uil-times fs-4"></i></button>
    </div>
    <div class="offcanvas-body p-4 px-md-5">
        <div class="row">
            <div class="col-12">
                <!-- Style switcher -->
                <div id="style-switcher">
                    <div>
                        <ul class="text-center list-unstyled mb-0">
                            <li class="d-grid"><a href="javascript:void(0)" class="rtl-version t-rtl-light"
                                                  onclick="setTheme('style-rtl')"><img
                                        src="assets/images/layouts/landing-light-rtl.png"
                                        class="img-fluid rounded-md shadow-md d-block" alt=""><span
                                        class="text-muted mt-2 d-block">RTL Version</span></a></li>
                            <li class="d-grid"><a href="javascript:void(0)" class="ltr-version t-ltr-light"
                                                  onclick="setTheme('style')"><img
                                        src="assets/images/layouts/landing-light.png"
                                        class="img-fluid rounded-md shadow-md d-block" alt=""><span
                                        class="text-muted mt-2 d-block">LTR Version</span></a></li>
                            <li class="d-grid"><a href="javascript:void(0)" class="dark-rtl-version t-rtl-dark"
                                                  onclick="setTheme('style-dark-rtl')"><img
                                        src="assets/images/layouts/landing-dark-rtl.png"
                                        class="img-fluid rounded-md shadow-md d-block" alt=""><span
                                        class="text-muted mt-2 d-block">RTL Version</span></a></li>
                            <li class="d-grid"><a href="javascript:void(0)" class="dark-ltr-version t-ltr-dark"
                                                  onclick="setTheme('style-dark')"><img
                                        src="assets/images/layouts/landing-dark.png"
                                        class="img-fluid rounded-md shadow-md d-block" alt=""><span
                                        class="text-muted mt-2 d-block">LTR Version</span></a></li>
                            <li class="d-grid"><a href="javascript:void(0)" class="dark-version t-dark mt-4"
                                                  onclick="setTheme('style-dark')"><img
                                        src="assets/images/layouts/landing-dark.png"
                                        class="img-fluid rounded-md shadow-md d-block" alt=""><span
                                        class="text-muted mt-2 d-block">Dark Version</span></a></li>
                            <li class="d-grid"><a href="javascript:void(0)" class="light-version t-light mt-4"
                                                  onclick="setTheme('style')"><img
                                        src="assets/images/layouts/landing-light.png"
                                        class="img-fluid rounded-md shadow-md d-block" alt=""><span
                                        class="text-muted mt-2 d-block">Light Version</span></a></li>
                            <li class="d-grid"><a href="../admin/index.html" target="_blank" class="mt-4"><img
                                        src="assets/images/layouts/light-dash.png"
                                        class="img-fluid rounded-md shadow-md d-block" alt=""><span
                                        class="text-muted mt-2 d-block">Admin Dashboard</span></a></li>
                        </ul>
                    </div>
                </div>
                <!-- end Style switcher -->
            </div><!--end col-->
        </div><!--end row-->
    </div>

    <div class="offcanvas-footer p-4 border-top text-center">
        <ul class="list-unstyled social-icon mb-0">
            <li class="list-inline-item mb-0"><a href="https://1.envato.market/doctris-template" target="_blank"
                                                 class="rounded"><i class="uil uil-shopping-cart align-middle" title="Buy Now"></i></a></li>
            <li class="list-inline-item mb-0"><a href="https://dribbble.com/shreethemes" target="_blank"
                                                 class="rounded"><i class="uil uil-dribbble align-middle" title="dribbble"></i></a></li>
            <li class="list-inline-item mb-0"><a href="https://www.facebook.com/shreethemes" target="_blank"
                                                 class="rounded"><i class="uil uil-facebook-f align-middle" title="facebook"></i></a></li>
            <li class="list-inline-item mb-0"><a href="https://www.instagram.com/shreethemes/" target="_blank"
                                                 class="rounded"><i class="uil uil-instagram align-middle" title="instagram"></i></a></li>
            <li class="list-inline-item mb-0"><a href="https://twitter.com/shreethemes" target="_blank"
                                                 class="rounded"><i class="uil uil-twitter align-middle" title="twitter"></i></a></li>
            <li class="list-inline-item mb-0"><a href="mailto:support@shreethemes.in" class="rounded"><i
                        class="uil uil-envelope align-middle" title="email"></i></a></li>
            <li class="list-inline-item mb-0"><a href="../../../index.html" target="_blank" class="rounded"><i
                        class="uil uil-globe align-middle" title="website"></i></a></li>
        </ul><!--end icon-->
    </div>
</div>
<!-- Offcanvas End -->

<!-- MOdal Start -->
<div class="modal fade" id="watchvideomodal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content video-modal rounded overflow-hidden">
            <!-- <video class="w-100" controls autoplay muted loop>
                    <source src="https://www.w3schools.com/html/mov_bbb.mp4" type="video/mp4">
                </video> -->
            <!--Browser does not support <video> tag -->
            <!--If you want to use your own video please set your files path-->

            <!-- <div class="ratio ratio-16x9">
                        <iframe src="https://www.youtube.com/embed/jNTZpfXYJa4?rel=0" title="YouTube video" allowfullscreen></iframe>
                    </div> -->
            <!--If you want to use the youtube link please try the above code-->

            <div class="ratio ratio-16x9">
                <iframe src="https://player.vimeo.com/video/99025203" title="Vimeo video" allowfullscreen></iframe>
            </div>
            <!--If you want to use the Vimeo link please try the above code-->
        </div>
    </div>
</div>
<style>
    .card img {
    width: 400px;
    height: 300px;
    object-fit: cover; /* Cắt ảnh để vừa khung */
}
</style>    

<script src="resources/script/wow.min.js"></script>
<!-- MOdal End -->
<script> new WOW().init();</script>
<!-- javascript -->
<script src="assets/js/bootstrap.bundle.min.js"></script>
<!-- SLIDER -->
<script src="assets/js/tiny-slider.js"></script>
<script src="assets/js/tiny-slider-init.js"></script>
<!-- Counter -->
<script src="assets/js/counter.init.js"></script>
<!-- Icons -->
<script src="assets/js/feather.min.js"></script>
<!-- Main Js -->
<script src="assets/js/app.js"></script>
</body>

</html>