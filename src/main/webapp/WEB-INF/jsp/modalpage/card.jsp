<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<div class="modal fade" id="cardmodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content" style="padding: 20px; width: 500px; height: 650px;">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
					<!--종료버튼  -->
				</button>

				<form id="card-field" method="post">
					<input id="cardNum" type="hidden" name="num" />
					<table class="table">
						<tr>
							<td align="center" colspan="2">
								<div id="Title"></div>
							</td>
						</tr>
						<tr>
							<td>USER</td>
							<td>
								<div id=card-user></div>
							</td>
						</tr>
						<tr>
							<td>SUBJECT</td>
							<td>
								<input id="cardSubject" type="text" class="form-control" style="width: 302px;" name="subject">
							</td>
						</tr>
						<tr>
							<td>CONTENT</td>
							<td>
								<textarea id="cardContent" name="content" class="form-control" rows="13" cols="40"></textarea>
							</td>
						</tr>
						<input id="cardListNum" type="hidden" name="listNum" /> 
						<input id="cardOrder" type="hidden" name="cardOrder" />
					</table>
					<div id="btn-area"><!-- btn insert area --></div>
				</form>
			</div>
		</div>
	</div>
</div>
