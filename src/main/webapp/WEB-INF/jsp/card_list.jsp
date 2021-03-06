<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="viser.card.*"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>jQuery UI Sortable - Display as grid</title>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

 <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
 <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>card</title>
</head>
<body>
	<div class="background">
		<%@ include file="./commons/top.jspf"%>				
		<div class="wrap">
		   <div id="top">
		     <div id="mini-menu"> 
		 	  <div class="btn-group-sm" role="group" aria-label="...">   
				<button type="button" class="btn btn-info" onclick="location.href='/board/boardlist?projectName=${projectName}'">
				목록
				</button>
				<button type="button" class="btn btn-info" href="#" data-toggle="modal" data-target="#invite">초대</button>
				<button type="button" class="btn btn-info" href="#" class="btn btn-default">EXIT</button>
			  </div>
			</div>
		  </div>  
		<div id="card-container" style = "overflow-x: auto;"> 
			  	<div id="tt" style="overflow:auto; width:10000px; text-align: left; ">  
					<%@include file = "/WEB-INF/jsp/modalpage/card.jsp"%>
					<ul id="cardlists" class = "boxsort">  		
						<c:forEach var="list" items="${lists}" varStatus="status">
							<li class="ui-state-default card_margin">
									<div class="card_wrap_top">
										<div>
											<textarea class="list_name" id="${list.listNum }-list-name" onkeyup="resize(this)" spellcheck="false" dir="auto" maxlength="512">${list.listName}</textarea>
										</div>
										<div>
											<a id="${list.listNum }-card-add-btn" class="btn btn-default" data-toggle="modal" href="#cardmodal">카드 추가</a>
											<script>
											  $(function ()
													    {
													        $('#'+${list.listNum }+'-list-name').change(function () {
													        	updateListName(${list.listNum },$('#'+${list.listNum }+'-list-name').val())
													        });
													    });
											
												$('#${list.listNum }-card-add-btn').click(function(){
													addCard(${list.listNum},$('#${list.listNum} li').length);
												});
											</script>
										</div>
							  		</div>
							  	
									<div >
										<div class="card_wrap">
											<ul id="${list.listNum}" class="connectedSortable sort_css">  
												<c:forEach var="card" items="${list.cards}" varStatus="status">
													<li id="${card.cardNum }"class="ui-state-default">
													<a id="${card.cardNum}-card-view-btn" class="card-modal-btn" data-toggle="modal" href="#cardmodal">${card.subject}</a>
													<script>
														$(document).ready(function(){
															$('#${card.cardNum}-card-view-btn').click(function(){
																viewCard(${card.cardNum});
															});
														});
													</script>
													</li>
												</c:forEach>
											</ul>
										</div>
									</div>
									<button type="button" class="btn btn-cardlist" href="#"  onclick="location.href='/lists/removeList?boardNum=${param.boardNum}&listOrder=${list.listOrder }'" style = "margin-bottom: 5px;">삭제</button>
								</li>		
							</c:forEach>
						</ul>
						<button id ="addbutton" class="btn btn-cardlist" type="button" data-toggle="collapse" data-target="#addList" aria-expanded="false" aria-controls="collapseExample" >
							List add.
						</button>
						<div class="collapse collapse-list" id="addList">
							<form method="post" action="/lists/addList">
							  <div class="form-group">
							    <label for="newListName">List name.</label>
							    <input type="text" class="form-control" name="listName" placeholder="리스트 이름을 입력하세요">
							    <input type="hidden" class="form-control" name="boardNum" value="${param.boardNum }"/>
							    <input id="currentListNum" type="hidden" class="form-control" name="listOrder" />
								<script>$('#currentListNum').val(''+$('#cardlists li').length);</script>
							  </div>
							  <button type="submit" class="btn btn-default" >생성</button>
							 </form>
						</div>
 					</div>
				</div>
				<iframe id='project-user' src="/project/memberlist"  name=user> 
				 	<p>Your browser does not support iframes.</p>
				</iframe>
				<iframe id='project-chat' src="/project/imagelist" name=chat>
				 	<p>Your browser does not support iframes.</p>
				</iframe>
		</div>
		<%@include file = "/WEB-INF/jsp/modalpage/upload.jsp"%> 
		<%@include file = "/WEB-INF/jsp/modalpage/invite.jsp" %>
	</div> 
</body>
<%@ include file="./commons/bottom.jspf"%>
</div>
</html>
<script>
function upload_popup(){
	$('#uploadmodal').modal();
}
</script>


<script>
var currentCardNum;

function viewCard(currentCardNum){
	$.ajax({
		type:'get',
		data:{
			cardNum:currentCardNum
		},
		url:'/cards/viewcard',
		dataType:'json',
		success:function (data){
			$('#card-field').attr("action","/cards/updatecard");
			$('#Title').html("<h2>View_Card</h2>");
			$('#cardNum').val(data.cardNum);
			$('#card-user').html("<input type='hidden' name='userId' value='"+data.userId+"'>"+data.userId+"</input>");
			$('#cardSubject').val(data.subject);
			$('#cardContent').val(data.content);
			var btn="";
			btn+="<input type='submit' class='btn btn-default' value='Modify'/>";
			btn+="<input type='reset' class='btn btn-default' value='Reset' />";
			btn+="<input type='button' class='btn btn-default'  value='List' data-dismiss='modal' />";
			btn+="<input type='button' id='delete-card' class='btn btn-default' value='Delete' />";
			$('#btn-area').html(btn);
			$('#delete-card').attr("onclick","location.href='/cards/removecard?num="+data.cardNum+"&listNum="+data.listNum+"&cardOrder="+data.cardOrder+"'");
		},
		error:ajaxError
	});
}

function addCard(cardListNum,currentCardOrder){
	$.ajax({
		type:'get',
		data:{
			listNum:cardListNum,
			cardOrder:currentCardOrder
		},
		url:"/cards/createcardForm",
		dataType:'json',
		success:function (data){
			$('#cardSubject').val(data.subject);
			$('#cardContent').val(data.content);
			$('#card-field').attr("action","/cards/createcard");
			$('#Title').html("<h2>CREATE_Card</h2>");
			$('#card-user').html("<input type='hidden' name='userId' value='${userId}'>${userId}</input>");
			$('#cardListNum').val(cardListNum);
			$('#cardOrder').val(currentCardOrder);
			var btn="";
			btn+="<input type='submit' class='btn btn-default' value='Submit'/>";
			btn+="<input type='reset' class='btn btn-default' value='Reset' />";
			btn+="<input type='button' class='btn btn-default'  value='List' data-dismiss='modal' />";
			$('#btn-area').html(btn);
		},
		error:ajaxError
	});
}

function ajaxError(){
	alert("데이터 로딩 오류");
}
</script>

 <script>
 
 var boardNum=${boardNum};
 var startListOrder;
 var updateListOrder;
 
  $( function() {
       $( ".boxsort" ).sortable({
            update: function(event, ul) { 
            	updateListOrder=ul.item.index();
                 console.log('list update: '+ updateListOrder);
                 changeListOrder();
             },
             start: function(event, ul) {
            	 startListOrder=ul.item.index();
                 console.log('list start: ' + startListOrder);
             },
         });
       $(".card_wrap_top").disableSelection();
  } );
  
  function changeListOrder(){
	  	$.ajax({
	  		type:'get',
			data:{
				num:boardNum,
				current:startListOrder,
				update:updateListOrder
			},
			url:"/lists/updateListOrder",
			dataType:'text',
			error:ajaxError
		});		  
	}

  var startListOrder;
  var updateListOrder;
  var startCardOrder;
  var updateCardOrder;
  
  $( function() {
    $( ".connectedSortable" ).sortable({
          update:function(event, ui) { 
    		  updateListOrder=ui.item.parent().parent().parent().parent().index();
    		  updateCardOrder= ui.item.index();
    		  if(updateListOrder==startListOrder){
    			  
	         	  console.log('update> card receive: ' + updateListOrder);
	              console.log('card update: '+ updateCardOrder);
	              changeCardOrder();
    		  }
          },
          receive:function(event, ui) { 
    		  updateListOrder=ui.item.parent().parent().parent().parent().index();
    		  updateCardOrder= ui.item.index();
    		  console.log('receive> card receive: ' + updateListOrder);
              console.log('card update: '+ updateCardOrder);
              changeCardOrder();
          },
          start: function(event, ui) {
        	 startListOrder=ui.item.parent().parent().parent().parent().index();
    		 startCardOrder= ui.item.index();
         	 console.log('start> card receive: ' + startListOrder);
             console.log('card start: ' + startCardOrder);
          },
          
      connectWith: ".connectedSortable"
    }).disableSelection();
  } ); 
  
  function changeCardOrder(){
	  	$.ajax({
	  		type:'get',
			data:{
				num:boardNum,
				currentList:startListOrder,
				updateList:updateListOrder,
				currentCard:startCardOrder,
				updateCard:updateCardOrder
			},
			url:"/lists/updateCardOrder",
			dataType:'text',
			error:ajaxError
		});		  
	}
  
 </script>
  
<script>
function resize(obj) {
  obj.style.height = "1px";
  obj.style.height = (12+obj.scrollHeight)+"px";
}

function updateListName(listNum,listName){
	$.ajax({
	type:'post',
	data:{
		num:listNum,
		name:listName
	},
	url:"/lists/updateListName",
	error:ajaxError
	});
}
</script>
