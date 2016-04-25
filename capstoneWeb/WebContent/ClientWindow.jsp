<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="problemDomain.Client, java.util.ArrayList,logic.ClientManager,logic.EmployeeManager,exceptions.DatabaseConnectionException" %>
<%@page import="problemDomain.Organization"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
	EmployeeManager em = new EmployeeManager();

	if(session.getAttribute("user") == null || em.getEmployeeInfo((Integer)session.getAttribute("user")) == null)
	{
		response.sendRedirect("index.jsp?error=main&message=Not Logged In!!");
		em.close();
		return;
	}
	em.close();
	
	boolean error = false;
	String errorMessage = "";
	ClientManager cm = new ClientManager();
	ArrayList<Client> clients = new ArrayList<Client>();
	try {
		if(session.getAttribute("searchResults") == null)
			clients = (ArrayList<Client>) cm.getClientList();
		else
		{
			clients = (ArrayList<Client>) session.getAttribute("searchResults");
			session.setAttribute("searchResults", null);
		}
	} catch(DatabaseConnectionException e) {
		error = true;
		errorMessage = e.getMessage();
	}
	
	if(request.getParameter("error") != null && request.getParameter("error").equals("main")) {
		error=true;
		errorMessage = request.getParameter("message");
	}
%>

<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
		<title>Indus Recreational Facility | Client Management</title>
		
		<!-- Main page styling -->
		<link href="css/style.css" rel="stylesheet"  type="text/css" media="screen" />
		
		<!-- List styling -->
		<link href="css/list.css" rel="stylesheet"  type="text/css" media="screen" />
		
		<!-- JQuery Main -->
		<script type="text/javascript" src="js/jquery-latest.js"></script>
		
		<!-- JQuery AutoComplete -->
		<link rel="stylesheet" href="css/jquery.autocomplete.css" type="text/css" />
		<script type="text/javascript" src="js/jquery.bgiframe.min.js"></script>
		<script type="text/javascript" src="js/jquery.dimensions.js"></script>
  		<script type="text/javascript" src="js/jquery.autocomplete.js"></script>
  		
  		<!-- Lightbox -->
		<link href="css/facebox.css" rel="stylesheet" type="text/css" media="screen" />
		<script src="js/facebox.js" type="text/javascript"></script> 
		
		<script type="text/javascript">
			//Run on page load
		    jQuery(document).ready(function($) {
				//Make all a tags with a rel="facebox" open a facebox
		      	$('a[rel*=facebox]').facebox({
		        	loading_image : '/facebox/loading.gif',
		        	close_image   : '/facebox/closelabel.gif'
		      	}); 

				//setup for autocomplete
		      	$("#searchAC").autocomplete("ClientManager");
		    });
	  	</script>
	  	
	  	<% if(error==true) { %>
	  	<script type="text/javascript">
			jQuery(document).ready(function($) {
				jQuery.facebox({ ajax: 'error.jsp?message=<%= errorMessage %>'});
			});
		</script>
		<% } %>
		
		<% if(request.getParameter("error") != null && request.getParameter("error").equals("info")) { %>
	  	<script type="text/javascript">
			jQuery(document).ready(function($) {
				jQuery.facebox({ ajax: 'ClientInfo.jsp?error=true'});
			});
		</script>
		<% } %>
	</head>
	<body>
		<div id="topbg"></div>

		<div id="main">
			<div id="header">
				<div id="hdr-overlay"></div>
				<div id="hdr-box1" class="box"></div>
				<div id="hdr-box2" class="box"></div>
				<div id="hdr-box3" class="box"></div>
				<div id="hdr-box4" class="box"></div>
				<h1>Indus Recreational Facility</h1>
				<div id="logout">
					<a href="LoginManager?logout=true">Logout</a>
				</div>
			</div>

			<ul id="menu">
				<li><a href="index.jsp"><span></span>Home</a></li>
				<li><a href="BookingWindow.jsp"><span></span>Schedule</a></li>
				<li><a href="InvoiceWindow.jsp"><span></span>Accounting</a></li>
				<li><a class="sel" href="ClientWindow.jsp"><span></span>Clients</a></li>
				<li><a href="FacilityWindow.jsp"><span></span>Facilities</a></li>
				<li><a href="EmployeeWindow.jsp"><span></span>Employees</a></li>
				<li><a href="OrganizationWindow.jsp"><span></span>Organizations</a></li>
				<li><a href="ManagementWindow.jsp"><span></span>Management</a></li>
			</ul>

			<div id="content">
				<div class="search">
					<form action="ClientManager?do=search" method="post">
						Search Clients: <br />
						<input type="text" id="searchAC" name="searchText" /> <input type="submit" name="search" value="Search" /> <input type="submit" name="reset" value="Clear Results" />
					</form>
				</div>
				<div class="listInfo">
					<span style="float:left">Showing Results 1-<%= clients.size() %> of <%= clients.size() %></span>
					<span style="float:right"><a href="ClientInfo.jsp" rel="facebox">New Client</a></span><br />
				</div>
				<table class="list">
					<tr class="head">
						<th>Given Name</th>
						<th>Surname</th>
						<th>Email</th>
						<th>Home Phone</th>
						<th>Work Phone</th>
						<th>Cell Phone</th>
						<th>Organization</th>
					</tr>
					<%
						if (clients.size()==0)
						    out.println("<tr><td colspan=\"5\">No clients found</td></tr>");
						else
						{
						    for (int i = 0; i < clients.size(); i++)
						    {
				    %>
				    
					<tr onclick="jQuery.facebox({ ajax: 'ClientInfo.jsp?client=<%= clients.get(i).getId() %>' });">
						<td><%= clients.get(i).getGivenName() %></td>
						<td><%= clients.get(i).getSurname() %></td>
						<td><%= clients.get(i).getEmail() %></td>
						<td><%= clients.get(i).getHomePhone() %></td>
						<td><%= clients.get(i).getWorkPhone() %></td>
						<td><%= clients.get(i).getCellPhone() %></td>
						<td>
						<% 
							ArrayList<Organization> orgs = clients.get(i).getOrganization();
							String orgList="";
							for (int j=0; j<orgs.size(); j++)
							{
								if (j<orgs.size()-1)
									orgList += orgs.get(j).getName()+"<br>";
								else
									orgList += orgs.get(j).getName();
							}
							
							out.println(orgList);
						%>
						</td>
					</tr>
					
					<%
						    }
						}
						cm.close();
				    %>
				</table>
				<div class="cleaner"></div>
				<div id="footer">
					&nbsp;
				</div>
			</div>
		</div>		
	</body>
</html>