//ajax 加载效果
//$(document).ajaxStart(loading).ajaxStop(clear_loading).ajaxComplete(clear_loading).ajaxError(clear_loading);

//加载提示
function loading(text){
	$('#loading').css('top', window.pageYOffset+(window.innerHeight)/3);
	$('#loading').show();
	showOverlay();
}

function showOverlay(){
	scroll = getScroll();
	if (scroll.t != 0) {
		$('#overlay').css('top', scroll.t);
	}
	$('#overlay').show();
}

function clear_overlay(){
	$('#overlay').hide();
}

//清除加载提示
function clear_loading(){
	clear_overlay();
	$('#loading').hide();
}


$(function() {
	$('#province').change(function() {
		val = this[this.selectedIndex].value;
		if (val == '-1') {
			return;
		}
		$.post(BASEURL + '/index.php/ajax/city', {
			val:val
		}, function(result) {
			$("#city").empty();
			$("#city").append('<option value="-1">--选择城市--</option>');
			$("#county").empty();
			$("#county").append('<option value="-1">--选择地区--</option>');
			for(i = 0; i < result.length; i++) {
				$("#city").append('<option value="'+result[i].code+'">'+result[i].name+'</option>');
			}
		}, 'json');
	});
	
	$('#city').change(function() {
		val = this[this.selectedIndex].value;
		if (val == '-1') {
			return;
		}
		$.post(BASEURL + '/index.php/ajax/county', {
			val:val
		}, function(result) {
			$("#county").empty();
			$("#county").append('<option value="-1">--选择地区--</option>');
			for(i = 0; i < result.length; i++) {
				$("#county").append('<option value="'+result[i].code+'">'+result[i].name+'</option>');
			}
		}, 'json');
	});
	/*
	$('#statusList li').live('click', function () {
		val = $(this).attr('id');
		$('#currentPage').val(1);
		statusClick(val);
		$('#bookDetail').hide();
	});
	
	$('#categoryList li').live('click', function () {
		val = $(this).attr('id');
		if ($(this).attr('class') == 'actLi' && val == 'statusAll') {
			return;
		}
		$('#currentPage').val(1);
		switch(val) {
			case 'nearCity':
				nearClick('city');
			break;
			case 'nearProvince':
				nearClick('province');
			break;
			case 'nearCounty':
				nearClick('county');
			break;
			case 'statusAll':
				$('#pageCategory').val('statusAll');
				$('#pageStatus').val(0);
				categoryClick();
			break;
			default :
				$('#pageCategory').val(val);
				categoryClick();
			break;
		}
		$('#bookDetail').hide();
	});
	
	$('#nearStore').click(function () {
		if ($(this).attr('class') == 'whiteBlock') {
			return;
		}
		val = $('#pageNear').val();
		$('#currentPage').val(1);
		nearClick(val);
		$('#myStore').attr('class', 'normalBlock');
		$('#nearStore').attr('class', 'whiteBlock');
		$('#statusList').empty();
		$('#bookDetail').hide();
	});
	
	$('#myStore').click(function () {
		if ($(this).attr('class') == 'whiteBlock') {
			return;
		}
		$('#nearStore').attr('class', 'normalBlock');
		$('#myStore').attr('class', 'whiteBlock');
		$('#pageCategory').val('statusAll');
		$('#pageStatus').val(0);
		$('#currentPage').val(1);
		$('#uid').val(0);
		categoryClick();
		$('#bookDetail').hide();
	});
	
	$('#booksPage li').live('click', function () {
		if ($(this).attr('class') == 'actPageLi') {
			return;
		}
		val = $(this).attr('id');
		$('#currentPage').val(val);
		if ($('#pageCategory').val() == 'statusAll' && $('#pageStatus').val() != 0) {
			statusClick($('#pageStatus').val());
		} else {
			categoryClick();
		}
		$('#bookDetail').hide();
	});
	
	$('#bookPrivate a').live('click', function () {
		type = $(this).attr('id');
		if (type == 'back') {
			$('#bookDetail').hide();
			$('#booksList').show();
			if ($('#pageCnt').val() > 1) {
				$('#booksPage').show();
			}
		} else {
			ubid = $('#ubid').val();
			bookDetail(ubid, type);
		}
		return false;
	});
	*/
	/*
	$('#booksList li').live('click', function () {
		ubid = $(this).attr('id');
		if (ubid.substr(0,1) == 'u') {
			$('#uid').val(ubid.substr(1));
			categoryClick();
		} else {
			bookDetail(ubid, 'self');
		}
	});
	*/
	$('#morebutton a').click(function(){
		$('#moreCategorys').show();
		$('#morebutton a').hide();
		$('#lessbutton a').show();
	});
	$('#lessbutton a').click(function(){
		$('#moreCategorys').hide();
		$('#morebutton a').show();
		$('#lessbutton a').hide();
		
	});
	
	
	$('#message_btn').click(function (e){
		$('#message_box').modal({
			containerCss:{
			 	border:"4px",
			 	solid:"#444",
				color:"#bbb",
				backgroundColor:"#444",
				borderColor:"#fff",
				height:"186px",
				padding:"10px",
				width:"486px"
			},
			overlayClose:true		
		});
		return false;
	});
	
	$('#book_Comment').click(function () {
		comment = $('#shoutContent').val();
		syncTitle = "";//$('#syncTitle').val();
		syncDouban = false;//$('#syncCheckbox').attr('checked');
		sync = 0;
		syncRate = 0;

		if (syncDouban== true) {
			if (mbStringLength(comment) < 150) {
				alert('同步到豆瓣，评论不得少于50个汉字');
				return;
			}
			if (getPostLength(syncTitle) == 0) {
				alert('同步到豆瓣，评论标题不能为空');
				return;
			}
			sync = 1;
			syncRate = 5;//$('#syncRate').val();
			if (syncRate != 1 && syncRate != 2 && syncRate != 3 && syncRate != 4 && syncRate != 5) {
				alert('同步到豆瓣，评分有误！');
				return;
			}
		}
		bid = $('#bid').val();
		len = getPostLength(comment);
		
		if (len == 0) {
			alert('评论不能为空！');
		} else if (len > 80) {
			alert('评论不能超过80个字！');
		} else {
			$.post(BASEURL + '/index.php/ajax/comment', {
				bid:bid,
				comment:comment,
				sync: sync,
				title: syncTitle,
				rate: syncRate
			}, function(result) {
				//alert('<li>' + result.author + ':' + comment + '</li>');
				$.modal.close();
			}, 'json');

		}
	});

/*
	$('#bookSource img').click(function(){
		val = $(this).attr('id');
		bid = $('#bid').val();		
		
		$.post(BASEURL + '/index.php/ajax/index', {
			t: 'source',
			bid: bid,
			val: val
		}, function(result) {

			for (i = 0; i < $('#bookSource img').length; i++) {
				d = $('#bookSource img')[i].src.split('/');
				d[d.length - 1] = result['img'][i + 1];
				$('#bookSource img')[i].src = d.join('/') + '.png';
				$('#bookRate img')[i].src = d.join('/') + '.png';
			}
			syncRate = $('#syncRate').val(result['userSource']);
		}, 'json');
	});
	
	$('#bookStatus li').click(function(){

		val = $(this).attr('id');
		bid = $('#bid').val();
		//alert(val + '-' + bid);
		$.post(BASEURL + '/index.php/ajax/index', {
			t: 'changeStatus',
			bid: bid,
			val: val
		}, function(result) {
			$('#bookStatus li')['0'].className = result['1'];
			$('#bookStatus li')['1'].className = result['2'];
			$('#bookStatus li')['2'].className = result['4'];
			
		}, 'json');
	});
*/	
	$('#sendMessage').click(function () {

		message = $('#message_content').val();
		toUid = $('#mUid').val();
		len = getPostLength(message);

		if (len == 0) {
			alert('私信不能为空！');
		} else if (len > 80) {
			alert('私信不能超过80个字！');
		} else {
			$.modal.close();
			$('#loading').show();
			$.post(BASEURL + '/index.php/ajax/message', {
				message: message,
				toUid: toUid
			}, function(result) {

				if (result.err) {
					alert(result.err);
				} else {
					if ($('#message').html() != null) {
						$('#message').append('<li>我:' + message + '<br />' + result.date + '</li>');
					} else {
						$('#loading').hide();
						alert('私信已经发出');
					}
				}
			}, 'json');
		}
	});

	$('#cancelMessage').click(function(){
		$.modal.close();
	});
	
	$('#form_set_sync a').click(function(){
		var ref = $(this).attr('ref');
		if ($(this).attr('id')=='unbind_'+ref) {
			
			$.post(BASEURL + '/index.php/ajax/unbind', {
				t: 'unbind',
				target: ref 
			}, function(result) {
				//alert(result.result);
				location.href= BASEURL + '/index.php/setting/index'
			}, 'json');
		}
	});
	
	function dialogue(content, title) {
		/* 
		 * Since the dialogue isn't really a tooltip as such, we'll use a dummy
		 * out-of-DOM element as our target instead of an actual element like document.body
		 */
		$('<div />').qtip(
		{
			content: {
				text: content,
				title: title
			},
			position: {
				my: 'center', at: 'center', // Center it...
				target: $(window) // ... in the window
			},
			show: {
				ready: true, // Show it straight away
				modal: {
					on: true, // Make it modal (darken the rest of the page)...
					blur: false // ... but don't close the tooltip when clicked
				}
			},
			hide: false, // We'll hide it maunally so disable hide events
			style: 'ui-tooltip-light ui-tooltip-rounded ui-tooltip-dialogue', // Add a few styles
			events: {
				// Hide the tooltip when any buttons in the dialogue are clicked
				render: function(event, api) {
					$('button', api.elements.content).click(api.hide);
				},
				// Destroy the tooltip once it's hidden as we no longer need it!
				hide: function(event, api) { api.destroy(); }
			}
		});
	}
	// Our Alert method
	function Alert(message)
	{
		// Content will consist of the message and an ok button
		var message = $('<p />', { text: message }),
			ok = $('<button />', { text: 'Ok', 'class': 'full' });
 
		dialogue( message.add(ok), '提示' );
	}
	// Our Confirm method
	function Confirm(question, callback)
	{
		// Content will consist of the question and ok/cancel buttons
		var message = $('<p />', { text: question }),
			ok = $('<button />', { 
				text: '确认',
				click: function() { callback(true); }
			}),
			cancel = $('<button />', { 
				text: '取消',
				click: function() { callback(false); }
			});
 
		dialogue( message.add(ok).add(cancel), '是否确认?' );
	}
 

	// $('#user_mind').qtip(
	// {		
		// id:'fd',
		// content: {
			// text: $('#feedback'),
			// title: {
				// text: '请花点时间给我们一点建议：）',
				// button: true
			// }
		// },
		// position: {
			// my: 'center', // ...at the center of the viewport
			// at: 'center',
			// target: $(window)
		// },
		// hide: true,
		// show: {
			// ready: false,
			// event:'click',
			// modal: {
				// on: true,
				// // Don't let users exit the modal in any way
				// blur: false,
				// escape: true
			// }
		// },
		// style: {
			// classes: 'ui-tooltip-light ui-tooltip-rounded',
			// tip: false			
		// },
		// events: {
			// render: function() {
				// alert("a")
				// // $('#btnSubmitFeedback').bind('click', function() {
				  // // alert('User clicked on "zhongyu OK"');
				  // // $('#ui-tooltip-fd').qtip('hide');
				// // });
// // 				
			// }
		// }
	// });
	
	
	$('#btnSubmitFeedback').click(function(event) {
		// Grab and store input elements
		//Alert($('#feedbackform').serialize());
		var content = $('#feedback_content').val();
		var name = $('#feedback_name').val();
		var contact = $('#feedback_contact').val();
		len = getPostLength(content);
								
		if (len == 0 || content=='问题或意见') 
			Alert('建议长度不能为零，请填写建议后再确定发送!');
		else
		{
			$.post(BASEURL + '/index.php/ajax/mind', {
				content: content,
				contact: contact,
				name: name
			}, function(result) {
				if (!result.result) {
					Alert(result.result);
				} else {
					Alert('我们已经收到建议，谢谢');
					$('#ui-tooltip-fd').qtip('hide');
				}
			}, 'json');
		}
		// Prevent normal form submission
		event.preventDefault();		
	});
	/*
	$('#btnCancelFeedback').click(function(event) {
		$('#ui-tooltip-fd').qtip('hide');
		//event.preventDefault();		
	});
	*/
	
	// Our Prompt method
	function UserMindPrompt(question, initial, callback)
	{
		// Content will consist of a question elem and input, with ok/cancel buttons
		var message = $('<p />', { text: question }),
			input = $('<textarea />', { 
				val: initial,
				style:'width:295px; height:60px;resize: none; margin:2px 0px 10px 0px; float:left;color:#666666;'
			}),
			ok = $('<button />', { 
				text: '确定',
				click: function() { callback(input.val()); }
			}),
			cancel = $('<button />', {
				text: '取消'
				//click: function() { callback(null); }
			});
 
		dialogue( message.add(input).add(ok).add(cancel), '我们一直在努力' );
	}
	
	$("#user_mind").floatdiv({right:"0px",bottom:"100px"});
	
	/**
	 * X人收藏
	 */
	$('#bookUserCollect').qtip(
			{		
				id:'usercollect',
				content: {
					text: $('#collect_user')
					
				},
				position: {
					my: 'top left', // ...at the center of the viewport
					at: 'bottom center'
						//,target: $(window)
				},
		        show: {
		            event: 'click',
		            solo: true
		        },
		        hide: {
		            event: null,
		            fixed: true
		        },
				style: {
					classes: 'ui-tooltip-tipped'
				},
				events: {
		            show: function() {
		                // Tell the tip itself to not bubble up clicks on it
		               // $($(this).qtip('api').elements.tooltip).click(function() { return false; });
						if ( ! $('#collect_user').is(':has(a)') ) {
							return false;
						}
		                // Tell the document itself when clicked to hide the tip and then unbind
		                // the click event (the .one() method does the auto-unbinding after one time
		                $(document).one("click", function() { $("#bookUserCollect").qtip('hide'); });
		            }
		        }
			});

	/**
	 * X人在读 
	 */
	$('#bookUserReading').qtip(
			{		
				id:'userreading',
				content: {
					text: $('#reading_user')
					
				},
				position: {
					my: 'top left', // ...at the center of the viewport
					at: 'bottom center'
						//,target: $(window)
				},
		        show: {
		            event: 'click',
		            solo: true
		        },
		        hide: {
		            event: null,
		            fixed: true
		        },
				style: {
					classes: 'ui-tooltip-tipped'
				},
				events: {
		            show: function() {
		                // Tell the tip itself to not bubble up clicks on it
		               // $($(this).qtip('api').elements.tooltip).click(function() { return false; });
						if ( ! $('#reading_user').is(':has(a)') ) {
							return false;
						}
		                // Tell the document itself when clicked to hide the tip and then unbind
		                // the click event (the .one() method does the auto-unbinding after one time
		                $(document).one("click", function() { $("#bookUserReading").qtip('hide'); });
		            }
		        }
			});

	/**
	 * X人已读
	 */
	$('#bookUserRead').qtip(
			{		
				id:'userread',
				content: {
					text: $('#read_user')
					
				},
				position: {
					my: 'top left', // ...at the center of the viewport
					at: 'bottom center'
						//,target: $(window)
				},
		        show: {
		            event: 'click',
		            solo: true
		        },
		        hide: {
		            event: null,
		            fixed: true
		        },
				style: {
					classes: 'ui-tooltip-tipped'
				},
				events: {
		            show: function() {
		                // Tell the tip itself to not bubble up clicks on it
		               // $($(this).qtip('api').elements.tooltip).click(function() { return false; });
						if ( ! $('#read_user').is(':has(a)') ) {
							return false;
						}
		                // Tell the document itself when clicked to hide the tip and then unbind
		                // the click event (the .one() method does the auto-unbinding after one time
		                $(document).one("click", function() { $("#bookUserRead").qtip('hide'); });
		            }
		        }
			});
	/**
	 * X人想读
	 */
	$('#bookUserWish').qtip(
			{		
				id:'userwish',
				content: {
					text: $('#wish_user')
					
				},
				position: {
					my: 'top left', // ...at the center of the viewport
					at: 'bottom center'
						//,target: $(window)
				},
		        show: {
		            event: 'click',
		            solo: true
		        },
		        hide: {
		            event: null,
		            fixed: true
		        },
				style: {
					classes: 'ui-tooltip-tipped'
				},
				events: {
		            show: function() {
		                // Tell the tip itself to not bubble up clicks on it
		               // $($(this).qtip('api').elements.tooltip).click(function() { return false; });
						if ( ! $('#wish_user').is(':has(a)') ) {
							return false;
						}
		                // Tell the document itself when clicked to hide the tip and then unbind
		                // the click event (the .one() method does the auto-unbinding after one time
		                $(document).one("click", function() { $("#bookUserWish").qtip('hide'); });
		            }
		        }
			});
	/**
	 * X人推荐
	 */
	$('#bookUserRecommend').qtip(
			{		
				id:'userrecommend',
				content: {
					text: $('#recommend_user')
					
				},
				position: {
					my: 'top left', // ...at the center of the viewport
					at: 'bottom center'
						//,target: $(window)
				},
		        show: {
		            event: 'click',
		            solo: true
		        },
		        hide: {
		            event: null,
		            fixed: true
		        },
				style: {
					classes: 'ui-tooltip-tipped'
				},
				events: {
		            show: function() {
		                // Tell the tip itself to not bubble up clicks on it
		               // $($(this).qtip('api').elements.tooltip).click(function() { return false; });
						if ( ! $('#recommend_user').is(':has(a)') ) {
							return false;
						}
		                // Tell the document itself when clicked to hide the tip and then unbind
		                // the click event (the .one() method does the auto-unbinding after one time
		                $(document).one("click", function() { $("#bookUserRecommend").qtip('hide'); });
		            }
		        }
			});
	
	
	$('#bookCategoryName').qtip(
	{		
		id:'tag',
		content: {
			text: $('#categoryTags'),
			title: {
				text: '纠错：请选择图书分类',
				button: true
			}
		},
		position: {
			my: 'top left', // ...at the center of the viewport
			at: 'bottom center'
				//,target: $(window)
		},
		hide: false,
		show: {
			solo: true,
			ready: false,
			event:'click',
			modal: {
				on: false,
				// Don't let users exit the modal in any way
				blur: false,
				escape: true
			}
			
		},
		style: {
			classes: 'ui-tooltip-shadow ui-tooltip-tipped'
		},
		events: {
			render: function(event, api) {
				
			}
		}
	});

	
	$('#categoryTags ul li').click(function(){
		val = $(this).attr('id');
		
		Confirm('修改分类将影响此书的全局分类，请确认。', function(yes) {
			// do something with yes
			if(yes)
			{
				bid = $('#bid').val();
				
				$.post(BASEURL + '/index.php/ajax/index', {
					t: 'changeCategory',
					bid: bid,
					val: val
				}, function(result) {
					//alert($('#bookCategoryName').html());
					$('#bookCategoryName').html(result.Category);			
				}, 'json');
				
			}
		});
		$('#ui-tooltip-tag').qtip('hide');
	});
	
	
	$('#modifyUB').qtip(
	{		
		id:'statusSource',
		content: {
			text: $('#changeBookStatus'),
			title: {
				text: '修改：读书状态',
				button: true
			}
		},
		position: {
			my: 'center', // ...at the center of the viewport
			at: 'center',
			target: $(window)
		},
		hide: false,
		show: {
			solo: true,
			ready: false,
			event:'click',
			modal: {
				on: true,
				// Don't let users exit the modal in any way
				blur: false,
				escape: true
			}
			
		},
		style: {
			classes: 'ui-tooltip-light ui-tooltip-rounded'
		},
		events: {
			show:function(event){
				getBookStatus();
				getBookSource();
			},
			render: function(event, api) {
				
			}
		}
	});
	
	$('#bookStatus li a').click(function(){
		val = $(this).attr('status');
		$('#status').val(val);
		setBookStatus(val);
	});
	

	/**
	 * 点星直接修改
	 */
	$('#bookRate img').click(function(){
		val = $(this).attr('id');
		bid = $('#bid').val();		
				
		for (i = 0; i < $('#bookRate img').length; i++) 
		{
			d = $('#bookRate img')[i].src.split('/');
			d[d.length - 1] = 'start_empty';
			$('#bookRate img')[i].src = d.join('/') + '.png';
		}
		for (i = 0; i < val; i++) 
		{
			d = $('#bookRate img')[i].src.split('/');
			d[d.length - 1] = 'start_all';
			$('#bookRate img')[i].src = d.join('/') + '.png';
		}
		
		$('#source').val(val);
		
		
		var source = $('#source').val();
		var bid = $('#bid').val();
		
		$.post(BASEURL + '/index.php/ajax/BookStatusSource', {
			t: 'changeStatusSource',
			source: source,
			bid: bid
		}, function(result) {
			if (result)
			{	
				
				if($('#starCondition').html() == '请您评分:'){
					$('#starCondition').text("您的评分:");
				}
				$('#ui-tooltip-statusSource').qtip('hide');
			}
		}, 'json');
	
		// Prevent normal form submission
		event.preventDefault();	
		
	});
	
	$('#btnSubmitStatusSource').click(function(event) {	
		var status = $('#status').val();
		//var source = $('#source').val();//打分不再于此处进行
		var bid = $('#bid').val();
		
		$.post(BASEURL + '/index.php/ajax/BookStatusSource', {
			t: 'changeStatusSource',
			status: status,
			//source: source,
			bid: bid
		}, function(result) {
			if (result)
			{	
				if(status==0)
					$('#modifyUB').text('未标记');
				else if(status==1)
					$('#modifyUB').text('我在读');
				else if(status==2)
					$('#modifyUB').text('我已读');
				else if(status==4)
					$('#modifyUB').text('我想读');
				$('#ui-tooltip-statusSource').qtip('hide');
			}
		}, 'json');
	
		// Prevent normal form submission
		event.preventDefault();		
	});
	
	$('#shareToWeibo').click(function(event) {	
		$.post(BASEURL + '/index.php/ajax/syncenable', {			
		}, function(result) {
			if(result['r']==true){
				$('#shareToWeibo2').qtip("show");
				$('#choiceness_content').trigger('keyup');
			}else 
				Alert(result['msg']);
		}, 'json');
		
	});
	
	$('#shareToWeibo2').qtip(
	{		
		id:'choiceness',
		content: {
			text: $('#choiceness'),
			title: {
				text: '  推荐图书',
				button: true
			}
		},
		position: {
			my: 'center', // ...at the center of the viewport
			at: 'center',
			target: $(window)
		},
		hide: false,
		show: {
			solo: true,
			ready: false,
			event:'click',
			modal: {
				on: true,
				// Don't let users exit the modal in any way
				blur: false,
				escape: true
			}			
		},
		style: {
			classes: 'ui-tooltip-light ui-tooltip-rounded'				
		},
		events: {
			show:function(event){				
				$('#choiceness_content').focus();
			},
			render: function(event, api) {					
			},
			hide:function(event, api){
			}
		}
	});

	$('#choiceness_content').keyup( function () {
		len = getPostLength($('#choiceness_content').val());
		num = 140 - len;
		html = num + '/140';
		$('#contentTip').html(html);
	});
	
	$('#btnSubmitChoiceness').qtip(
	{					
		content: {
			text: $('#choicenessOK'),
			title: {
				text: '  推荐图书',
				button: true
			}
		},
		position: {
			my: 'center', at: 'center', // Center it...
			target: $(window) // ... in the window
		},
		show: {
			event:'click',
			ready: false, // Show it straight away
			modal: {
				on: true, // Make it modal (darken the rest of the page)...
				blur: false // ... but don't close the tooltip when clicked
			}
		},
		hide: true, // We'll hide it maunally so disable hide events
		style: 'ui-tooltip-light ui-tooltip-rounded ui-tooltip-dialogue', // Add a few styles					
		events: {
			render: function(event, api) {
				$('#btnChoicenessOK', api.elements.content).click(api.hide);
			},
			show:function(event){	
				var msg = $('#choiceness_content').val();		
				var bid = $('#bid').val();
				
				$('#ui-tooltip-choiceness').qtip('hide');
				$.post(BASEURL + '/index.php/ajax/Choiceness', {		
					bid: bid,
					msg: msg
				}, function(result) {	
					if (result)
					{	
						
					}			
				}, 'json');
			},
			hide: function(event, api) {   }
		}
	});	
	
	$('#removeUB').click(function(event){
		bid = $('#bid').val();
		Confirm("确认后将从书房中移除，要删除这本书吗？" , function(yes) {		
			if(yes)
			{
				$.post(BASEURL + '/index.php/ajax/RemoveUB', {
					bid: bid			
				}, function (result) {
					if (result) {
						//alert(result['msg']);
						location.href= BASEURL + '/index.php/site/main'; //uid/' + uid + '/status/'+ status + '/category/' + category;
					}
				}, 'json');
				
			}
		});
	});
	
});

function setBookStatus(status)
{
	switch(status) {
		case '1':
			$('#bookStatus li a')['0'].className = 'zd_sel';
			$('#bookStatus li a')['1'].className = 'yd';
			$('#bookStatus li a')['2'].className = 'xd';			
			$('#bookStatus li a')['3'].className = 'bbj';
		break;
		case '2':
			$('#bookStatus li a')['0'].className = 'zd';
			$('#bookStatus li a')['1'].className = 'yd_sel';
			$('#bookStatus li a')['2'].className = 'xd';			
			$('#bookStatus li a')['3'].className = 'bbj';
		break;
		case '3':
			
		break;
		case '4':
			$('#bookStatus li a')['0'].className = 'zd';
			$('#bookStatus li a')['1'].className = 'yd';
			$('#bookStatus li a')['2'].className = 'xd_sel';			
			$('#bookStatus li a')['3'].className = 'bbj';
		break;
		default :
			$('#bookStatus li a')['0'].className = 'zd';
			$('#bookStatus li a')['1'].className = 'yd';
			$('#bookStatus li a')['2'].className = 'xd';			
			$('#bookStatus li a')['3'].className = 'bbj_sel';
		break;
	}
}

function getBookStatus(){	
	bid = $('#bid').val();
	
	$.post(BASEURL + '/index.php/ajax/BookStatusSource', {
		t: 'getStatus',
		bid: bid
	}, function(result) {
		//alert(result['msg']);
		var val = result['r']['status'];		
		
		$('#status').val(val);
		setBookStatus(val);
	}, 'json');
}

function getBookSource(){	
	bid = $('#bid').val();
	
	$.post(BASEURL + '/index.php/ajax/BookStatusSource', {
		t: 'getSource',
		bid: bid
	}, function(result) {
		var imgResult = result['r']['img'];	

		for (i = 0; i < $('#bookSource img').length; i++) {
			d = $('#bookSource img')[i].src.split('/');
			d[d.length - 1] = imgResult[i + 1];
			$('#bookSource img')[i].src = d.join('/') + '.png';
		}
		
		var userSource = result['r']['userSource'];
		$('#source').val(userSource);
				
	}, 'json');
}

function formatBooks(books) {
	$('#booksList').empty();
	if (books) {
		for(i = 0; i < books.length; i ++) {
			$('#booksList').append('<li id="' + books[i]['ubid'] + '"><img src="' + books[i]['img'] + '" /><br/>' + books[i]['txt'] + '</li>');
		}
		$('#bookDetail').hide();
		$('#booksList').show();
	} else {
		$('#booksList').hide();
		$('#bookDetail').html('分类下暂无藏书');
		$('#bookDetail').show();
	}
}

function formatCategorys(categorys, val) {
	$('#categoryList').empty();
	for(i = 0; i < categorys.length; i ++) {
		html = '<li id="' + categorys[i]['id'] + '"';
		html += val == categorys[i]['id'] ? ' class="actLi">' : '>';
		html += categorys[i]['txt'] + ' ' + categorys[i]['cnt'] + '</li>';
		$('#categoryList').append(html);
	}
}

function formatStatus(status, val) {
	$('#statusList').empty();
	for(i = 0; i < status.length; i ++) {
		html = '<li id="' + status[i]['val'] + '"';
		html += val == status[i]['val'] ? ' class="actLi">' : '>';
		html += status[i]['txt'] + ' ' + status[i]['cnt'] + '</li>';
		$('#statusList').append(html);
	}
}

function formatPageList(pageList, val) {
	if (pageList.length <= 1) {
		$('#booksPage').hide();
	} else {
		$('#booksPage').show();
		$('#booksPage').empty();
		$('#booksPage').append('<li class="normalLi"><</li>');
		for(i = 0; i < pageList.length; i ++) {
			html = '<li';
			html += val == pageList[i] ? ' class="actPageLi"' : '';
			pVal = pageList[i] == '*' ? '...' : pageList[i];
			html += ' id="' + pVal + '">' + pVal + '</li>';
			$('#booksPage').append(html);
		}
		$('#booksPage').append('<li class="normalLi">></li>');
	}
	$('#pageCnt').val(pageList.length);
}
function statusClick(val) {
	page = $('#currentPage').val();
	$.post(BASEURL + '/index.php/ajax/bookstatus', {
		status: val,
		uid: $('#uid').val(),
		page: page
	}, function (result) {
		formatBooks(result['books']);
		if (result['categorys']) {
			category = val == 0 ? 'statusAll' : '';
			formatCategorys(result['categorys'], category);
		}
		if (result['status']) {
			formatStatus(result['status'], val);
			$('#pageStatus').val(val);
		}
		formatPageList(result['pageList'], page);
		$('#pageCategory').val('statusAll');
	}, 'json');
}

function categoryClick() {
	category = $('#pageCategory').val();
	status = $('#pageStatus').val();
	page = $('#currentPage').val();
	$.post(BASEURL + '/index.php/ajax/bookcategory', {
		category: $('#pageCategory').val(),
		status: $('#pageStatus').val(),
		page: $('#currentPage').val(),
		uid: $('#uid').val()
	}, function (result) {
		formatBooks(result['books']);
		if (result['categorys']) {
			formatCategorys(result['categorys'], category);
		}
		$('#pageCategory').val(category);
		if (result['status']) {
			formatStatus(result['status'], '');
		}
		formatPageList(result['pageList'], page);
	}, 'json');
}

function nearClick(val) {
	page = $('#currentPage').val();
	$.post(BASEURL + '/index.php/ajax/near', {
		type: val,
		page: page
	}, function (result) {
		if (result['categorys']) {
			formatCategorys(result['categorys'], 'near' + val.substring(0,1).toUpperCase() + val.substring(1));
		}
		formatBooks(result['books']);
		formatPageList(result['pageList'], page);
	}, 'json');
}

function bookDetail(ubid, type) {
	category = $('#pageCategory').val();
	status = $('#pageStatus').val();
	$.post(BASEURL + '/index.php/ajax/ubinfo', {
		ubid: ubid,
		type: type,
		status: status,
		category: category,
		uid: $('#uid').val()
	}, function (result) {
		if (result) {
			$('#booksList').hide();
			$('#booksPage').hide();
			$('#bookDetail').show();
			$('#bookDetail').html(result);
		}
	}, 'json');
}

function mbStringLength(s) {

	var totalLength = 0;
	var i;
	var charCode;

	for (i = 0; i < s.length; i++) {
		charCode = s.charCodeAt(i);
		if (charCode < 0x007f) {
			totalLength = totalLength + 1;
		} else if ((0x0080 <= charCode) && (charCode <= 0x07ff)) {
			totalLength += 2;
		} else if ((0x0800 <= charCode) && (charCode <= 0xffff)) {
			totalLength += 3;
      }
    }

    //alert(totalLength);
    return totalLength;
}


/**
 * 读取消息框中文字字数
 * 
 * @return
 */
function getPostLength(txt)
{
	var _zh = txt ? txt.match(/[^ -~]/g) : 0;
	var num = Math.ceil((txt.length + (_zh && _zh.length) || 0)/2);
	
	return num;
}

