<%@page import="java.util.ArrayList"%>
<%@page import="pojos.User"%>
<%@page import="Utility.FnErrorHandler"%>
<%
    try {
        ArrayList<User> addresslist = (ArrayList<User>) request.getAttribute("executeLoad");
        for (User user : addresslist) {
            String email = (String) FnSecurity.FnDecryptUserLoginCredentials.getInstance().process(String.valueOf(user.getEmail()));


%>
<table>
    <tr>
        <td>
            <label>
                User ID
            </label>
            <label style="margin-left:45px">
                : 
            </label>
            <input disabled="" value="<%= user.getIdUser()%>" type="text" id="<%= user.getIdUser() + "_adminAccounttxtuserID"%>"/>
        </td>
        <td>
            <label>
                Name
            </label>
            <label style="margin-left:100px">
                : 
            </label>
            <input type="text" value="<%= user.getName()%>" id="<%= user.getIdUser() + "_adminAccounttxtName"%>" />
        </td>
    </tr>
    <tr>
        <td>
            <label>
                Mobile No
            </label>
            <label style="margin-left:30px">
                : 
            </label>
            <input value="<%= user.getMobileNumber()%>"  type="text" id="<%= user.getIdUser() + "_adminAccounttxtMobileNo"%>"/>
        </td>
        <td>
            <label>
                Email
            </label>
            <label style="margin-left:88px">
                : 
            </label>
            <input  value="<%= email%>" type="text"  id="<%= user.getIdUser() + "_adminAccounttxtEmail"%>" />
        </td>
    </tr>
    <tr>
        <td>
            <label>
                Account Type
            </label>
            <label style="margin-left:5px">
                : 
            </label>
            <select  style="padding-left: 10px"  id="<%= user.getIdUser() + "_adminAccountselectType"%>" >
                <option<% if (user.getAccountType().equals("Admin")) {%> selected="" <%}%>>Admin</option>
                <option<% if (user.getAccountType().equals("User")) {%> selected="" <%}%>>User</option>
            </select>
        </td>
        <td>
            <label>
                Account Status
            </label>
            <label style="margin-left:10px">
                : 
            </label>
            <select  style="padding-left: 10px" id="<%= user.getIdUser() + "_adminAccountselectStatus"%>">
                <option<% if (user.getStatus() == Byte.parseByte("1")) {%> selected="" <%}%>>Active</option>
                <option<% if (user.getStatus() == Byte.parseByte("0")) {%> selected="" <%}%>>Deactive</option>
            </select>
        </td>
    </tr>
    <tr>
        <td colspan="2">
            <input type="button" value="Update" onclick="updateUserAdmin(<%= user.getIdUser()%>);"/>
        </td>
    </tr>
</table>
<%     }
    } catch (Exception e) {
        FnErrorHandler.executeErrorHandler(e);
    }
%>