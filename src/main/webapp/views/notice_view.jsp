<%@page import="bean.*"%>
<%@ page import="java.sql.*" %>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Notice</title>
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@300;400;600;700;800&display=swap" rel="stylesheet">    
    <link rel="stylesheet" href="assets/css/bootstrap.css">
    <link rel="stylesheet" href="assets/vendors/perfect-scrollbar/perfect-scrollbar.css">
    <link rel="stylesheet" href="assets/vendors/bootstrap-icons/bootstrap-icons.css">
    <link rel="stylesheet" href="assets/css/app.css">
    <link rel="shortcut icon" href="assets/images/favicon.svg" type="image/x-icon">
	
	<style>
		button {
            background-color: rgb(42, 105, 241);
            color: white;
            border: none;
            border-radius: 5px;
            height: 35px;
            width: 70px;
            cursor: pointer;
            margin: 0px 5px;
        }
        .content {
        	background-color: rgb(255, 255, 255);
        	border: none;
        	border-radius: 10px;
        	padding: 50px;
        }
	</style>
</head>
<body>
	<jsp:useBean id="noticeDAO" class="bean.NoticeDAO"></jsp:useBean>

    <div id="app">
        <div id="sidebar" class="active">
            <div class="sidebar-wrapper active">
                <div class="sidebar-header">
                    <div class="d-flex justify-content-between">
                        <div class="logo">
                            <a href="dashboard.jsp"><!-- <img src="assets/images/logo/logo.png" alt="Logo" srcset="">-->LOGO</a>
                        </div>
                        <div class="toggler">
                            <a href="#" class="sidebar-hide d-xl-none d-block"><i class="bi bi-x bi-middle"></i></a>
                        </div>
                    </div>
                </div>
                <div class="sidebar-menu">
                    <ul class="menu">
                        <li class="sidebar-title">Menu</li>

                        <li class="sidebar-item">
                            <a href="dashboard.jsp" class='sidebar-link'>
                                <i class="bi bi-grid-fill"></i>
                                <span>HOME</span>
                            </a>
                        </li>

                        <li class="sidebar-item  has-sub">
                            <a href="#" class='sidebar-link'>
                                <i class="bi bi-stack"></i>
                                <span>CUSTOMER</span>
                            </a>
                            <ul class="submenu ">
                                <li class="submenu-item ">
                                    <a href="customer.jsp">회원 관리</a>
                                </li>
                                <li class="submenu-item ">
                                    <a href="customer.jsp">기타</a>
                                </li>                                
                            </ul>
                        </li>

                        <li class="sidebar-item  has-sub">
                            <a href="#" class='sidebar-link'>
                                <i class="bi bi-collection-fill"></i>
                                <span>RESERVATION</span>
                            </a>
                            <ul class="submenu ">
                                <li class="submenu-item ">
                                    <a href="reservation.jsp">예약 관리</a>
                                </li>
                                <li class="submenu-item ">
                                    <a href="reservation.jsp">기타</a>
                                </li>
                            </ul>
                        </li>

                        <li class="sidebar-item  has-sub">
                            <a href="#" class='sidebar-link'>
                                <i class="bi bi-grid-1x2-fill"></i>
                                <span>SERVICE</span>
                            </a>
                            <ul class="submenu ">
                                <li class="submenu-item ">
                                    <a href="service.jsp">서비스 관리</a>
                                </li>
                                <li class="submenu-item ">
                                    <a href="service.jsp">기타</a>
                                </li>
                            </ul>
                        </li>

                        <li class="sidebar-item  has-sub">
                            <a href="#" class='sidebar-link'>
                                <i class="bi bi-hexagon-fill"></i>
                                <span>PRODUCT</span>
                            </a>
                            <ul class="submenu ">
                                <li class="submenu-item ">
                                    <a href="product.jsp">상품 관리</a>
                                </li>
                                <li class="submenu-item ">
                                    <a href="product.jsp">기타</a>
                                </li>
                             </ul>
                        </li>
 
                        <li class="sidebar-item active has-sub">
                            <a href="#" class='sidebar-link'>
                                <i class="bi bi-pen-fill"></i>
                                <span>NOTICE</span>
                            </a>
                            <ul class="submenu ">
                                <li class="submenu-item ">
                                    <a href="notice_list.jsp">공지 사항</a>
                                </li>
                                <li class="submenu-item ">
                                    <a href="notice_list.jsp">기타</a>
                                </li>
                            </ul>
                        </li>
                    </ul>
                </div>
                <button class="sidebar-toggler btn x"><i data-feather="x"></i></button>
           		</div>
        	</div>
	        <div id="main">
	            <header class="mb-3">
	                <a href="#" class="burger-btn d-block d-xl-none">
	                    <i class="bi bi-justify fs-3"></i>
	                </a>
	            </header>
	
	            <div class="page-heading">
	                <div class="page-title">
	                    <div class="row">
	                        <div class="col-12 col-md-6 order-md-1 order-last">
	                            <h3>공지사항</h3>
	                        </div>
	                        <div class="col-12 col-md-6 order-md-2 order-first">
	                            <nav aria-label="breadcrumb" class="breadcrumb-header float-start float-lg-end">
	                                <ol class="breadcrumb">
	                                    <li class="breadcrumb-item"><a href="login.jsp">로그아웃</a></li>                                    
	                                </ol>
	                            </nav>
	                        </div>
	                    </div>
	                </div>
	                <hr style="height: 5px;">
	                <section class="section">
	                <%	
	                	int notice_no = Integer.parseInt(request.getParameter("notice_no"));
						NoticeDTO noticeDTO = noticeDAO.getNoticeDetail(notice_no);
	                %>
		                <div>
	                        <div class="mb-5">
	                        	<div class="mt-5">
	                        		<h4><%=noticeDTO.getNotice_title()%></h4>
	                        	</div>
	                        	<div class="d-flex justify-content-between">
	                        		<div><h6>&#35;<%=noticeDTO.getNotice_no()%></h6></div>
	                        		<div><%=noticeDTO.getNotice_reg()%></div>
	                        	</div>
	                            <div class="content"><%=noticeDTO.getNotice_content()%></div>
	                        </div>
		                    <div class="container mb-5 d-flex justify-content-center gap-2">
	                    		<%
		                    		NoticeDTO previousNotice = noticeDAO.getPreviousNotice(notice_no);
		                    		NoticeDTO nextNotice = noticeDAO.getNextNotice(notice_no);
	                    			
		                    	// 버튼 세 개가 보이되, 맨 첫 게시글이나 맨 마지막 게시글 페이지에서 이전/다음 페이지 버튼이 없어도 목록버튼 위치가 변하지 않도록 함
		                    		// 조회 가능한 공지사항 범위를 넘어선 글의 번호를 가져오면 null이 아니라 0이 반환됨. int의 기본값이라 그런 듯? 
		                    		if(previousNotice.getNotice_no() != 0){
		                    	%>		<!-- 이전 게시글이 있을 때에만 보이는 버튼 -->
				                    	<button onclick="location.href='notice_view.jsp?notice_no=<%=previousNotice.getNotice_no()%>'">이전</button>
		                    	<%
		                    		} else {
		                    	%>		<!-- 자리만 차지하고 있는 버튼 -->
		                    			<button disabled aria-disabled="true" style="visibility: hidden;">이전</button>
		                    	<%
		                    		}
		                    	%>
                    			<button onclick="location.href='notice_list.jsp'">목록</button>
                    			<%
									if(nextNotice.getNotice_no() != 0){
								%>		<!-- 다음 게시글이 있을 때에만 보이는 버튼 -->
										<button onclick="location.href='notice_view.jsp?notice_no=<%=nextNotice.getNotice_no()%>'">다음</button>
								<%
									} else {
								%>		<!-- 자리만 차지하고 있는 버튼 -->
										<button disabled aria-disabled="true" style="visibility: hidden;">다음</button>
								<%
									}
								%>
		                    </div>
		                </div>
                </section>
	            <footer>
				    <div class="footer clearfix mb-0 text-muted">
				        <div class="float-start">
				            <p>2024 &copy; ACORN</p>
				        </div>
				        <div class="float-end">
				            <p><span class="text-danger"><i class="bi bi-heart"></i></span> by <a href="#">거니네조</a></p>                                
				        </div>
				    </div>
				</footer>
	        </div>
	    </div>
	</div>
    <script src="assets/vendors/perfect-scrollbar/perfect-scrollbar.min.js"></script>
    <script src="assets/js/bootstrap.bundle.min.js"></script>
    <script src="assets/js/main.js"></script>
</body>

</html>