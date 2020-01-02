$(document).ready(function(){
	$("#btn-search").on('click', function(){
		let query = document.getElementById("search").value
		let top  = document.getElementById("top").value

		let search = "http://10.10.117.169/zmsearch/src/php/query.php?t="+top+"&q="+query;
		$.ajax({url: search, 
			success: function(result){
				JSON.parse(result).forEach(el => {
					$("#result").append(makeResult(el));
				});
			
			},
			error: function(err){
				console.log('err :', err);
			}
		});
	});

	function makeResult(data){
		console.log('data :', data);
		let card='<div class="card card-result">';
			card+='<div class="card-body">';
			card+='<a href=""><h4>'+data.title+'</h4></a>';
			card+='<br>';
			card+='<p>'+data.url+'</p>';
			card+='<br>';
			card+='<p>'+data.prew+'</p>';
			card+='</div></div>';
		return card;
	}
});
