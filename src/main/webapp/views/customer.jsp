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
    <title>회원 관리</title>
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@300;400;600;700;800&display=swap" rel="stylesheet">    
    <link rel="stylesheet" href="assets/css/bootstrap.css">
    <link rel="stylesheet" href="assets/vendors/perfect-scrollbar/perfect-scrollbar.css">
    <link rel="stylesheet" href="assets/vendors/bootstrap-icons/bootstrap-icons.css">
    <link rel="stylesheet" href="assets/css/app.css">
    <link rel="shortcut icon" href="assets/images/favicon.svg" type="image/x-icon">
    <style>
		a {
		    color: inherit;  /* 부모 요소의 텍스트 색상을 따르도록 설정 */
		    text-decoration: none;  /* 밑줄 없애기 */
		}		
		a:visited {
		    color: inherit;
		}		
		a:hover {
		    color: inherit;
		}		
		a:active {
		    color: inherit;
		}
		.list-group-item.detail{
			font-size: small;
		}
		.bi-plus-square {
			display: inline-block;
			transform: translateY(2px);
		}
		.bi-person-fill{
			display: inline-block;
			transform: translateY(6px);
			margin-right: 5px;
		}
		.bi-bell-fill{
			display: inline-block;
			transform: translateY(3px);
			margin-right: 5px;
		}
		.bi-box-arrow-right{
			display: inline-block;
			transform: translateY(3px);
		}
	</style>
</head>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js"></script>
<script>
	function check() {
		if(document.search.keyWord.value == "") {
			document.search.keyWord.focus();
			return;
		}
		
		document.search.submit();
	}
</script>
<body>
	<jsp:useBean id="customerDAO" class="bean.CustomerDAO"></jsp:useBean>
	<jsp:useBean id="board" class="bean.CustomerDTO"></jsp:useBean>
	
	<%
	    request.setCharacterEncoding("UTF-8");
	
	    // 이름 등급 날짜 조회
	    String keyField = request.getParameter("keyField");
	    String filterValue = request.getParameter("filterValue");
	    String startDate = request.getParameter("startDate");
	    String endDate = request.getParameter("endDate");
	
	    // 페이징 변수
	    int totalcnt = 0;     //총 글의 개수
		int numPerPage = 10;  //한 페이지당 보여질 글의 개수
		int totalPage = 0;    //총 페이지 수
		int nowPage = 0;      //현재 선택된 페이지
		int beginPerPage = 0; //페이지별 시작번호
		int pagePerBlock = 2; //블럭당 페이지 수
		int totalBlock = 0;   //총 블럭 수
		int nowBlock = 0;     //현재 블럭
	
	    ArrayList<CustomerDTO> list = null;
	
	    // 날짜 필터링 적용
	    if (startDate != null && !startDate.isEmpty() && endDate != null && !endDate.isEmpty()) {
	        list = (ArrayList<CustomerDTO>) customerDAO.getCustomerByregdate(startDate, endDate);
	    } else {
	        list = (ArrayList<CustomerDTO>) customerDAO.getCustomerDTOList(keyField, filterValue);
	    }
	
	    // 전체 고객 수 구하기
	    totalcnt = list.size();
	
	    // 페이지 수 계산
	    totalPage = (int) Math.ceil((double) totalcnt / numPerPage);
	    if (request.getParameter("nowPage") != null) {
	        nowPage = Integer.parseInt(request.getParameter("nowPage"));
	    }
	    beginPerPage = nowPage * numPerPage;
	    totalBlock = (int) Math.ceil((double) totalPage / pagePerBlock);
	    if (request.getParameter("nowBlock") != null) {
	        nowBlock = Integer.parseInt(request.getParameter("nowBlock"));
	    }
	%>


    <div id="app">
        <div id="sidebar" class="active">
            <div class="sidebar-wrapper active">
                <div class="sidebar-header">
                    <div class="d-flex justify-content-between">
                        <div class="logo">
                            <a href="dashboard.jsp">로고</a>
                        </div>
                        <div class="toggler">
                            <a href="#" class="sidebar-hide d-xl-none d-block"><i class="bi bi-x bi-middle"></i></a>
                        </div>
                    </div>
                </div>
                <div class="sidebar-menu">
                    <ul class="menu">
                        <li class="sidebar-title">메뉴</li>

                        <li class="sidebar-item ">
                            <a href="dashboard.jsp" class='sidebar-link'>
                                <i class="bi bi-grid-fill"></i>
                                <span>홈</span>
                            </a>
                        </li>

                        <li class="sidebar-item active has-sub">
                            <a href="#" class='sidebar-link'>
                                <i class="bi bi-stack"></i>
                                <span>고객</span>
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
                                <span>예약</span>
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
                                <span>서비스</span>
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
                                <span>상품</span>
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
                        <li class="sidebar-item has-sub">
                            <a href="#" class='sidebar-link'>
                            	<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-fill-gear" viewBox="0 0 16 16"><path d="M11 5a3 3 0 1 1-6 0 3 3 0 0 1 6 0m-9 8c0 1 1 1 1 1h5.256A4.5 4.5 0 0 1 8 12.5a4.5 4.5 0 0 1 1.544-3.393Q8.844 9.002 8 9c-5 0-6 3-6 4m9.886-3.54c.18-.613 1.048-.613 1.229 0l.043.148a.64.64 0 0 0 .921.382l.136-.074c.561-.306 1.175.308.87.869l-.075.136a.64.64 0 0 0 .382.92l.149.045c.612.18.612 1.048 0 1.229l-.15.043a.64.64 0 0 0-.38.921l.074.136c.305.561-.309 1.175-.87.87l-.136-.075a.64.64 0 0 0-.92.382l-.045.149c-.18.612-1.048.612-1.229 0l-.043-.15a.64.64 0 0 0-.921-.38l-.136.074c-.561.305-1.175-.309-.87-.87l.075-.136a.64.64 0 0 0-.382-.92l-.148-.045c-.613-.18-.613-1.048 0-1.229l.148-.043a.64.64 0 0 0 .382-.921l-.074-.136c-.306-.561.308-1.175.869-.87l.136.075a.64.64 0 0 0 .92-.382zM14 12.5a1.5 1.5 0 1 0-3 0 1.5 1.5 0 0 0 3 0"/></svg>                               
                                <span>직원</span>
                            </a>
                            <ul class="submenu ">
                                <li class="submenu-item ">
                                    <a href="member.jsp">직원 관리</a>
                                </li>
                                <li class="submenu-item ">
                                    <a href="member.jsp">기타</a>
                                </li>
                            </ul>
                        </li>
 
                        <li class="sidebar-item  has-sub">
                            <a href="#" class='sidebar-link'>
                                <i class="bi bi-megaphone-fill"></i>
                                <span>공지</span>
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
	                            <h3>회원 관리</h3>
	                        </div>
	                        <div class="col-12 col-md-6 order-md-2 order-first">
	                            <nav aria-label="breadcrumb" class="breadcrumb-header float-start float-lg-end">
	                                <ol class="breadcrumb">
	                                    <li class="breadcrumb-item">
	                                    <i class="bi bi-person-fill text-primary" style="font-size:x-large; " ></i>
	                       	 			<i class="bi bi-bell-fill text-primary" style="font-size:larger; line-height: 10px;" ></i>
                                    	<a href="login.jsp"><span class="badges badge bg-primary">로그아웃&nbsp;<i class="bi bi-box-arrow-right " ></i></span></a>
                                   	</li>                                   
	                                </ol>
	                            </nav>
	                        </div>
	                    </div>
	                </div>
	                <hr style="height: 5px;">	                
					<div class="row form-group">
                    <form method="post" action="customer.jsp" class="col-4 d-flex">
                        <input type="date" onclick="this.showPicker()" class="form-control" id="startDate" name="startDate">&nbsp;&nbsp;~&nbsp;&nbsp;
                        <input type="date" onclick="this.showPicker()" class="form-control" id="endDate" name="endDate">
                        <input type="submit" class="btn btn-outline-success" value="조회">
                    </form >
                    <form class="col-4"></form>
                    <form method="post" action="customer.jsp" class="col-4 d-flex justify-content-end align-items-end search-filter">
                            <select name="keyField" class="choices form-select" style="width: 100px; display: inline-block;">
                                <option value="customer_name">이름</option>
                                <option value="customer_rank">등급</option>
                            </select>
                            <input type="text" name="filterValue" id="filterValue" placeholder="검색" class="form-control" value="<%= filterValue != null ? filterValue : "" %>">
                            <input type="submit" class="btn btn-outline-success" value="조회" >
                    </form>
                	</div>
                	
	                <section class="section">
	                <div class="buttons d-flex justify-content-end align-items-end">
                        <a href="customerAdd.jsp" class="btn btn-outline-success" style="margin-right:0px">등록</a>
                    </div>
					<div class="row" id="table-hover-row">
						<div class="col-12">
							<div class="card">
								<div class="card-content">
									<div class="table-responsive">
										<table class="table table-hover mb-0" id="customerTable">
											<thead>
												<tr>
													<th width="5%" class="text-center">ID</th>
                                                    <th width="10%" class="text-center">이름</th>
                                                    <th width="5%" class="text-center">성별</th>
                                                    <th width="15%" class="text-center">연락처</th>
                                                    <th width="15%" class="text-center">e-mail</th>
                                                    <th width="10%" class="text-center">회원 등록일</th>
                                                    <th width="10%" class="text-center">회원등급</th>
                                                    <th width="30%" class="text-center">특이사항</th>
												</tr>
											</thead>
											<tbody>
												<%
	                                            		for(int i=beginPerPage; i < beginPerPage + numPerPage && i < totalcnt; i++){
	                                            			board = list.get(i);
	                                            %>
												<tr>
													<td class="text-bold-500 text-center"><%=board.getCustomer_id() %></td>
													<td class="text-bold-500 text-center"><a href="customerRead.jsp?customer_id=<%= board.getCustomer_id() %>"><%= board.getCustomer_name() %></a>
													<td class="text-bold-500 text-center"><%=board.getCustomer_gender() %></td>
													<td class="text-bold-500 text-center"><%=board.getCustomer_tel() %></td>
													<td class="text-bold-500 text-center"><%=board.getCustomer_mail() %></td>
													<td class="text-bold-500 text-center"><%=board.getCustomer_reg() %></td>
													<td class="text-bold-500 text-center"><%=board.getCustomer_rank() %></td>
													<td class="text-bold-500 text-center"><%=board.getCustomer_note() != null ? board.getCustomer_note() : "" %></td>
												</tr>
												
												<%
	                                            		}
	                                            %>

											</tbody>
										</table>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="buttons d-flex justify-content-end align-items-end">
						<button onclick="downloadExcel();" class="btn btn-outline-warning" style="margin-right: 0px;">
							엑셀 다운로드</button>
					</div>
					<div
						class="col-12 d-flex justify-content-center align-items-center">
						<nav aria-label="Page navigation example">
							<ul class="pagination pagination-primary">
								<!-- 왼쪽 화살표 이동 기능 -->
								<% if(nowPage == 0) { %>
									<li class="page-item disabled"><a class="page-link" href="#" tabindex="-1" aria-disabled="true">
										<span aria-hidden="true"><i class="bi bi-chevron-left"></i></span></a></li>
								<% } else {%>
									<li class="page-item"><a class="page-link" href="customer.jsp?nowPage=<%=((nowBlock - 1) * pagePerBlock)%>&nowBlock=<%=nowBlock - 1%>">
										<span aria-hidden="true"><i class="bi bi-chevron-left"></i></span></a></li>
								<% } %>

								<!-- 페이지 반복 -->
								<%
									for (int i = 0; i < pagePerBlock; i++) {
										int currentPage = (nowBlock * pagePerBlock) + i;
										if (currentPage >= totalPage)
											break;
								%>
										<li class="page-item <%=currentPage == nowPage ? "active" : ""%>">
										<a class="page-link" href="customer.jsp?nowPage=<%=currentPage%>&nowBlock=<%=nowBlock%>">
											<%=currentPage + 1%></a>
										</li>
								<%
									}
								%>
								
								<!-- 오른쪽 화살표 이동 기능 -->
								<% if(nowBlock >= totalBlock-1) { %>
									<li class="page-item disabled"><a class="page-link" href="#">
										<span aria-hidden="true"><i class="bi bi-chevron-right"></i></span></a></li>
								<% } else {%>
								
								<li class="page-item"><a class="page-link" href="customer.jsp?nowPage=<%=(nowBlock + 1) * pagePerBlock%>&nowBlock=<%=nowBlock + 1%>">
										<span aria-hidden="true"><i class="bi bi-chevron-right"></i></span></a></li>
								<% } %>
							</ul>
						</nav>
					</div>
				</section>
	            <footer>
	                <div class="footer clearfix mb-0 text-muted">
	                    <div class="float-start">
	                        <p>2024 &copy; ACORN</p>
	                    </div>
	                    <div class="float-end">
	                        <p><span class="text-danger"><i class="bi bi-heart"></i></span> by <a
	                                href="#main">거니네조</a>
	                        </p>                                
	                    </div>
	                </div>
	            </footer>
	        </div>
	    </div>
	</div>
	<script src="assets/vendors/perfect-scrollbar/perfect-scrollbar.min.js"></script>
	<script src="assets/js/bootstrap.bundle.min.js"></script>
	<script src="assets/js/main.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js"></script>
	<script>
            function downloadExcel() {
                var table = document.getElementById("customerTable");
                var wb = XLSX.utils.table_to_book(table, { sheet: "회원 관리" });
                XLSX.writeFile(wb, '회원_관리.xlsx');
            }
        </script>
</body>

</html>