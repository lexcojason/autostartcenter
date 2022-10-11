<%--
* Licensed Materials - Property of IBM
* 
* 5724-U18, 5737-M66
* 
* (C) COPYRIGHT IBM CORP. 2006, 2021 All Rights Reserved.
* 
* US Government Users Restricted Rights - Use, duplication or
* disclosure restricted by GSA ADP Schedule Contract with
* IBM Corp.
--%><%--
This JSP is the handler for StartCenter-Options component.
It provides a wrapper user interface for children hyperlink controls
--%>
<%@ include file="../common/simpleheader.jsp" %><%
StartCenterOptions scOptions =((StartCenterOptions)control);
psdi.webclient.beans.startcntr.StartCenterAppBean scAppBean = (psdi.webclient.beans.startcntr.StartCenterAppBean)app.getAppBean();
Object scInfo[] = scAppBean.getStartCenters();
ArrayList startCenters= null;
if (scInfo == null)
	startCenters = new ArrayList();
else if (scInfo[0] == null)
	startCenters = new ArrayList();
else
	startCenters = (ArrayList)scInfo[0];

if(component.needsRender())
{
	String style = "";
	if(startCenters.size() > 1){
		style = " style='padding-top:4rem;' ";
	}
%>

<%@ page import="psdi.webclient.beans.startcntr.*" %>
<% 
// begin auto refresh
try 
{
  SessionContext sessionContext = new SessionContext(wcs);
  StartCenterAppBean startcenter = (StartCenterAppBean)sessionContext.getCurrentApp().getAppBean();
  psdi.mbo.MboRemote mbo = startcenter.getMbo();
  String where = "groupname = 'MAXADMIN' and userid in (select userid from maxuser where personid = '" + mbo.getUserInfo().getPersonId() + "')";
  psdi.mbo.MboSetRemote groups = mbo.getMboSet("$GROUPUSER", "GROUPUSER", where);
  groups.moveFirst(); 

  if ( !groups.isEmpty() ) 
  {
String refreshUrl = wcs.getMaximoRequestURI()
                  + "?event=loadapp&value=startcntr&"
                  + wcs.getUISessionUrlParameter()
                  + wcs.getCSRFTokenParameter();
%>
<script type="text/javascript"> setTimeout('window.location=window.location' ,10000); </script>
<% 
  } 
} 

catch (Exception e) 
{
  e.printStackTrace(); 
}
// end auto refresh
%>





		<table role="presentation" id="<%=id%>" class='scoo' <%=automationId%> border="0" width="100%" align="<%=reverseAlign%>" "<%=style%>">
			<tr>
				<td valign="top" align="<%=reverseAlign%>" nowrap>
					<table role="presentation" border="0" cellpadding="2" bordercolor="#111111" align="<%=reverseAlign%>">
					   <tr>
					<%
}//if render
					List children = scOptions.getChildren();

					if (children != null )
					{
						Iterator i = children.iterator();
						while (i.hasNext())
						{
							DatasrcInstance child = (DatasrcInstance)i.next();
							child.render();
						}
					}

if(component.needsRender())
{
					%>
				</tr>
				</table>
				</td>
			</tr>
		</table>
<%
}
%><%@ include file="../common/componentfooter.jsp" %>