function WriteYearOptions(YearsAhead)
{
  line = "";
  for (i=0; i<YearsAhead; i++)
  {
    line += "<OPTION>";
    line += NowYear - i;
  }
  return line;
}
function DaysInMonth(WhichMonth, WhichYear)
{
  var DaysInMonth = 31;
  if (WhichMonth == "04" || WhichMonth == "06" || WhichMonth == "09" || WhichMonth == "11") DaysInMonth = 30;
  if (WhichMonth == "02" && (WhichYear/4) != Math.floor(WhichYear/4))   DaysInMonth = 28;
  if (WhichMonth == "02" && (WhichYear/4) == Math.floor(WhichYear/4))   DaysInMonth = 29;
  return DaysInMonth;
}
function ChangeOptionDays(Which)
{
  DaysObject = eval("document.Form1." + Which + "Day");
  MonthObject = eval("document.Form1." + Which + "Month");
  YearObject = eval("document.Form1." + Which + "Year");
  Month = MonthObject[MonthObject.selectedIndex].text;
  Year = YearObject[YearObject.selectedIndex].text;
  DaysForThisSelection = DaysInMonth(Month, Year);
  CurrentDaysInSelection = DaysObject.length;
  if (CurrentDaysInSelection > DaysForThisSelection)
  {
    for (i=0; i<(CurrentDaysInSelection-DaysForThisSelection); i++)
    {
      DaysObject.options[DaysObject.options.length - 1] = null
    }
  }
  if (DaysForThisSelection > CurrentDaysInSelection)
  {
    for (i=0; i<(DaysForThisSelection-CurrentDaysInSelection); i++)
    {
      NewOption = new Option(DaysObject.options.length + 1);
      DaysObject.add(NewOption);
    }
  }
    if (DaysObject.selectedIndex < 0) DaysObject.selectedIndex == 0;
}
//选图


function Confirm(question, question2 ,  callback)
{
    // Content will consist of the question and ok/cancel buttons
    var message = $('<p />', { text: question }),
        q2 = $('<p />', { text: question2 }),
        ok = $('<button />', { 
            text: '确认',
            click: function() { callback(true); }
        }),
        cancel = $('<button />', { 
            text: '取消',
            click: function() { callback(false); }
        });

    dialogue( message.add(q2).add(ok).add(cancel), '提示' );
}

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


$(function() {
    var inputEl = $('input[name=nickname]');  
    inputEl.bind({
        focus: function() {         
            var newtop = $(this).offset().top-42;
            var newleft = $(this).offset().left-34;
            $('#nickname_remark').css('top',newtop);
            $('#nickname_remark').css('left',newleft);
            $('#nickname_remark').show();
        },
        blur: function() {
            $('#nickname_remark').hide();           
        }
    });
    
    
    $("#book_name").qtip({
        content:{text:'如 哈利•波特与混血王子；破折号写为“—”'},
       position: {
              my: 'bottom right', 
              at: 'top center'
       },
        show: {
            event: 'click'
          },
        hide:false,
         style: {
           classes: 'ui-tooltip-dark ui-tooltip-rounded'
         }
       });
    $("#book_name").focus(function() {
        $('#book_name').qtip("show");
    });
    $("#book_name").focusout(function() {
        $('#book_name').qtip("hide");
    });
    
    
    $("#series_name").qtip({
        content:{text:'如 哈利•波特系列#6'},
       position: {
              my: 'bottom right', 
              at: 'top center'
       },
        show: {
            event: 'click'
          },
        hide:false,
         style: {
           classes: 'ui-tooltip-dark ui-tooltip-rounded'
         }
       });
    $("#series_name").focus(function() {
        $('#series_name').qtip("show");
    });
    $("#series_name").focusout(function() {
        $('#series_name').qtip("hide");
    });
    
    
    $("#press").qtip({
        content:{text:'如 生活•读书•新知三联书店'},
       position: {
              my: 'bottom right', 
              at: 'top center'
       },
        show: {
            event: 'click'
          },
        hide:false,
         style: {
           classes: 'ui-tooltip-dark ui-tooltip-rounded'
         }
       });
    $("#press").focus(function() {
        $('#press').qtip("show");
    });
    $("#press").focusout(function() {
        $('#press').qtip("hide");
    });
    
    
    $("#author0").qtip({
        content:{text:'如 [哥伦比亚] 加西亚•马尔克斯'},
       position: {
              my: 'bottom right', 
              at: 'top center'
       },
        show: {
            event: 'click'
          },
        hide:false,
         style: {
           classes: 'ui-tooltip-dark ui-tooltip-rounded'
         }
       });
    $("#author0").focus(function() {
        $('#author0').qtip("show");
    });
    $("#author0").focusout(function() {
        $('#author0').qtip("hide");
    });
    
    
    $("#identify0").qtip({
       content:{text:'-作者<br/><br/>-第二作者<br/><br/>-译者<br/><br/>-编者'},
       position: {
              my: 'bottom right', 
              at: 'top center'
       },
        show: {
            event: 'click'
          },
        hide:false,
        style: {
          classes: 'ui-tooltip-dark ui-tooltip-rounded'
        }
      });
    $("#identify0").focus(function() {
        $('#identify0').qtip("show");
  });
    $("#identify0").focusout(function() {
        $('#identify0').qtip("hide");
  });
    
    
    Now = new Date();
    NowDay = Now.getDate();
    NowMonth = Now.getMonth();
    NowYear = Now.getYear();
    if (NowYear < 2000) NowYear += 1900;
    $("#FirstSelectYear").html(WriteYearOptions(100));
  
 





//输入框蓝色边框
$(".uploadinfo").focus(function() {
      $(this).css('border' , '1px solid #23a4d6');  
      $(this).css('box-shadow' , 'inset 0 0 5px #23a4d6');
});
$(".uploadinfo").focusout(function() {
      $(this).css('border' , '1px solid #666666');  
      $(this).css('box-shadow' , 'none');
});
$(".book_textarea").focus(function() {
      $(this).css('border' , '1px solid #23a4d6');  
      $(this).css('box-shadow' , 'inset 0 0 5px #23a4d6');
});
$(".book_textarea").focusout(function() {
      $(this).css('border' , '1px solid #666666');  
      $(this).css('box-shadow' , 'none');
});



$("#book_name").keydown(function(event){
    if(event.which == 13){
        $("#preSubBtn").trigger("click");
    }
});
$("#isbn").keydown(function(event){
    if(event.which == 13){
        $("#preSubBtn").trigger("click");
    }
});

// $("#preSubBtn").click(function() {
   $("#book_name").blur (function() {
    
    if($("#book_name").val().trim() == ''){
        
        $("#book_name").focus();
        
    } else {
        
        $("#loading").css('display' , 'inline');
        
        if($("#isbn").val().trim() == '') $("#notice").html('');
        
 
                        DOUBAN.apikey = 
                        DOUBAN.searchBooks({
                            startindex:0,
                            maxresults:20,
                             keyword:$("#book_name").val(),
                            callback:function(result){
                                            $("#loading").css('display' , 'none');
            if (result)
            {   
                //初始成
                $("#notice").html('&emsp;');
                $("#booksList").empty();
                $('#preSubBtn').css('display' , 'none');
                $('#preRstBtn').css('display' , 'none');
                $('#preConBtn').css('display' , 'inline');
                $('#preRstBtn2').css('display' , 'inline');
                $("#middle_title").css('display' , 'none');
                
                if(result['notice']){
                    $("#notice").html('&emsp;'+result['notice']);   
                    $('#preSubBtn').css('display' , 'inline');
                    $('#preRstBtn').css('display' , 'inline');
                    $('#preConBtn').css('display' , 'none');
                    $('#preRstBtn2').css('display' , 'none');
                }
                
                    if(result){        
                    for(i = 0; i < 20; i++) {
                        
                        // var book = result['r'].result['books'][i];
                        var book_name = result.entry[i].title.$t;
                        var doubanisbn = result.entry[i]['db:attribute'];
                        
                        for(j = 0; j < doubanisbn.length; j++) {
                           // alert(arr1[j]['@rel']); 
                           if(doubanisbn[j]['@name']=="isbn13"){
                               // alert("a");
                               var isbn13 = doubanisbn[j]['$t'];
                               break;
                           }
                        }  
                        // result.stationsinzoneresult.location[i]['@x']
                        // var dataObj = eval(result);
                        // if(result.entry[i].link['@rel'])
                        
                        var arr1 = result.entry[i].link;  
                         
                        for(j = 0; j < arr1.length; j++) {
                           // alert(arr1[j]['@rel']); 
                           if(arr1[j]['@rel']=="image"){
                               // alert("a");
                               var doubanimg = arr1[j]['@href'];
                               break;
                           }
                        }  
                      
                        
                            var a = 0;
                            a++;

                        
                        var link = $("#url").val() + '/site/searchdetail/sid/' + book_name['sid'];

                        var li = "<li id='libook'  '><a href='javascript:void(0);' id="+isbn13+" name='aisbn' onclick='$(\"#book_name\").val(\""+book_name+"\");$(\"#isbn\").val(\""+isbn13+"\")'><img src='" + doubanimg + "'/></a><br/>" + book_name + "</li>"; 
 
                        $("a[name='isbn13']").onclick=function(){alert("as");};

                         $("#booksList").append(li);
   
                            function xianshi(){
                              alert("a");  
                            };
                    }


                    $("#middle_title").css('display' , 'inline');
                    
                } else if(!result['notice'] && ( !result['r']) || !result['r'].result || result['r'].result['total'] <=0){
                    
                    location.href = $("#url").val() + '/setting/uploadbook/name/' + 
                            encodeURIComponent($("#book_name").val()) + '/isbn/' + encodeURIComponent($("#isbn").val());
                    
                }

            } 
}
        });

    }
    

});


//取消创建
$(".greyBtn").click(function() {
    $("#booksList").empty();
    
    $('#preSubBtn').css('display' , 'inline');
    $('#preRstBtn').css('display' , 'inline');
    $('#preConBtn').css('display' , 'none');
    $('#preRstBtn2').css('display' , 'none');
    
    $("#book_name").val('');
    $("#isbn").val('');
});

//继续创建
$("#preConBtn").click(function() {
    if($("#book_name").val().trim() != ''){
        
        location.href = $("#url").val() + '/setting/uploadbook/name/' + 
                encodeURIComponent($("#book_name").val()) + '/isbn/' + encodeURIComponent($("#isbn").val());
        
    }
});



//添加作者 
$("#addIdentify").click(function(){
    if($("table tbody tr").length < 38){
        var id = $("table tbody tr").length - 18;
        $("#table_author"+(id-1)).after("<tr class='tbTr' id='table_author"+id+"'><td class='tbTitle'>&nbsp;</td><td colspan=3><input type='text' name='author"+id+"' id='author"+id+"' class=\'uploadinfo\' style=\'width:140px\' /><span class=\'textTitle\'> 身份 </span><input type='text' name='identify"+id+"' id='identify"+id+"' class=\'uploadinfo\' style=\'width:97px\' /></td></tr>");
        
        var inputEl = $('input[id=author'+id+']');
        inputEl.bind({
            focus: function() {         
                inputEl.css('border' , '1px solid #23a4d6');    
                inputEl.css('box-shadow' , 'inset 0 0 5px #23a4d6');
            },
            blur: function() {
                inputEl.css('border' , '1px solid #666666');    
                inputEl.css('box-shadow' , 'none');         
            }
        });
        
        inputEl.qtip({
            content:{text:'如 [哥伦比亚] 加西亚•马尔克斯'},
           position: {
                  my: 'bottom right', 
                  at: 'top center'
           },
            show: {
                event: 'click'
              },
            hide:false,
             style: {
               classes: 'ui-tooltip-dark ui-tooltip-rounded'
             }
           });
        inputEl.focus(function() {
            inputEl.qtip("show");
        });
        inputEl.focusout(function() {
            inputEl.qtip("hide");
        });
        
        
        var inputSl = $('input[id=identify'+id+']');
        inputSl.bind({
            focus: function() {         
                inputSl.css('border' , '1px solid #23a4d6');    
                inputSl.css('box-shadow' , 'inset 0 0 5px #23a4d6');
            },
            blur: function() {
                inputSl.css('border' , '1px solid #666666');    
                inputSl.css('box-shadow' , 'none');         
            }
        });
            
        inputSl.qtip({
               content:{text:'-作者<br/><br/>-第二作者<br/><br/>-译者<br/><br/>-编者'},
               position: {
                      my: 'bottom right', 
                      at: 'top center'
               },
                show: {
                    event: 'click'
                  },
                hide:false,
                style: {
                  classes: 'ui-tooltip-dark ui-tooltip-rounded'
                }
              });
            inputSl.focus(function() {
            inputSl.qtip("show");
          });
            inputSl.focusout(function() {
                inputSl.qtip("hide");
          });
    }
    return false;
});

/***创建图书***/
$("#SubBtn").click(function(){
    
    $("#loading").css('display' , 'inline');
    
    var author = '';
    
    for(i=1;i<=($("table tbody tr").length - 19);i++){
        
        if($("#author" + i).val() != '')
            author += $("#author" + i).val() + ',';
        
        if($("#identify" + i).val() != '')
            author += $("#identify" + i).val() + ',';
        
    }

    $.post(BASEURL + '/index.php/ajax/AddBook', {
        book_name: $("#book_name").val(),
        isbn: $("#isbn").val(),
        uid: $("#uid").val(),
        series_name:$("#series_name").val(),
        img_name:$("#image_url").val(),
        author:author,
        author_display:$("#author0").val() + ' ' + $("#identify0").val(),
        press:$("#press").val(),
        press_time:$("#FirstSelectYear").val()+'-'+$("#FirstSelectMonth").val()+'-'+$("#FirstSelectDay").val(),
        page:$("#page").val(),
        price:$("#price").val(),
        price_unit:$("#price_unit").val(),
        material:$("#material").val(),
        version:$("#version").val(),
        book_info:$("#book_info").val(),
        author_info:$('#author_info').val(),
        category:$("#category option:selected").text(),
        shortcategory:$("#category option:selected").val()
    }, function(result) {
        $("#loading").css('display' , 'none');
        if (result)
        {   
            //初始
            $("#book_name_notice").html('');
            $("#isbn_notice").html('');
            $("#page_notice").html('');
            $("#price_unit_notice").html('');
            $("#material_notice").html('');
            
            if(result['r'] && result['r'].code != 10000){//有错
                
                var error = result['r'].data;
                if(error['book_name']){$("#book_name_notice").html(error['book_name']);}
                if(error['isbn']){$("#isbn_notice").html(error['isbn']);}
                if(error['page']){$("#page_notice").html(error['page']);}
                if(error['price_unit']){$("#price_unit_notice").html(error['price_unit']);}
                if(error['material']){$("#material_notice").html(error['material']);}
                if(error['version']){$("#version_notice").html(error['version']);}
                
            } else if(result['r'] && result['r']['result']){
            
                Confirm('感谢您让我们多认识了一本书！:)' , '是否将这本书也添加到您的书房中？' , function(yes) {      
                    if(yes)
                    {
                        $.post(BASEURL + '/index.php/ajax/bookroomadd', {
                            id: result['r']['result']['id']
                        }, function (result) {
                            if (result) {
                                location.replace( $("#url").val() + '/site/main');
                            }
                        }, 'json');
                        
                    } else {
                        location.replace( $("#url").val() + '/site/main');
                    }
                });
                
            } else {
                 
                alert('添加图书失败');
            }
            
        }
    }, 'json'); 
});


});





