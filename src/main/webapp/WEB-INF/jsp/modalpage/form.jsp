<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var = "ActionUrl" value = "/project/createProject" />
<c:set var = "Modal_id" value = "CreateNewProJect" />
<c:set var = "InputName" value = "projectName" />
<c:if test = "${isReadBoard}">
<c:set var = "ActionUrl" value = "/board/createBoard" />
<c:set var = "Modal_id" value = "CreateNewBoard" />
<c:set var = "InputName" value = "boardName" />
</c:if>

<div class="modal fade" id="${Modal_id}" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
      <div class="modal-body">
        <h2 class="modal-title" id="MyModalLabel">Create ${Target}</h2>
     
     	</div>  
		 <form class="form-inline" action="${ActionUrl}" method="get">
		 	 <div class="form-group">
		 	   <label for="exampleInputName2" style="padding-right: 10px"><h2>Name</h2></label>
			   <input type="text" class="form-control" name="${InputName}" placeholder="Input ${Target} name.." style="width:300px">
			   <c:if test = "${isReadBoard}">
			   <input type="hidden" name="projectName" value="${param.Project_name}">
			   </c:if>
			  </div>
    	 </div>
		  
     	 	<div class="modal-footer">
    		    <button type="button" class="btn btn-default" data-dismiss="modal">나가기</button>
     		   <button type="submit" class="btn btn-primary">생성하기</button>
        </form>
    </div>
   </div>
  </div>
</div>