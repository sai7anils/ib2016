$(document).ready(function() {

  $('.msg-icon').click(function(event) {
    $('.dropdown-message').toggleClass('active');
  });

  //FUND STARTUP
  var menu_active = $('.list-menu li:first-child');
  var fund_content = 1;
  $('.list-menu li').click(function(event) {
    menu_active.removeClass('active');
    menu_active.addClass('done');
    $(this).addClass('active');
    menu_active = $(this);

    $('.fund:nth-of-type(' + fund_content + ')').css('display','none');
    fund_content = $(this).index() + 1;
    if(fund_content === 5){
      $('#btn-next').css('display','none');
    }
    if(fund_content <= 5){
      $('#btn-next').css('display','block');
    }
    else{
      $('#btn-next').css('display','none');
    }
    $('.fund:nth-of-type(' + fund_content + ')').css('display','block');
  });

  $('#btn-next').click(function(){
    menu_active.removeClass('active');
    menu_active.addClass('done');
    if(fund_content === 5){
      $('#btn-next').css('display','none');
    }
    if(fund_content < 5){
      $('#btn-next').css('display','block');
    }
    $('.fund:nth-of-type(' + fund_content + ')').css('display','none');
    fund_content = fund_content + 1;
    menu_active = $('.list-menu li:nth-child(' + fund_content + ')');
    menu_active.addClass('active');
    $('.fund:nth-of-type(' + fund_content + ')').css('display','block');
  })
  // $('.custom-file-upload').bind('cocoon:after-insert', function(e, part_costing) {
  //   part_costing[0].getElementsByTagName('input')[0].value = part_id;
  //   part_costing[0].getElementsByTagName('input')[1].value = part_name;
  //   console.debug("Added part_costing...");
  // });



  //http://www.onextrapixel.com/2012/12/10/how-to-create-a-custom-file-input-with-jquery-css3-and-php/
  ;(function($) {
    // Browser supports HTML5 multiple file?
    var multipleSupport = typeof $('<input/>')[0].multiple !== 'undefined',
        isIE = /msie/i.test( navigator.userAgent );

    $.fn.customFile = function() {

      return this.each(function() {

        var $file = $(this).addClass('custom-file-upload-hidden'), // the original file input
          $wrap = $('<div class="file-upload-wrapper">'),
          $input = $('<input type="text" class="file-upload-input" placeholder="Choose File To"/>'),
          // Button that will be used in non-IE browsers
          $button = $('<button type="button" class="file-upload-button">Upload</button>'),
          // Hack for IE
          $label = $('<label class="file-upload-button" for="'+ $file[0].id +'">Select a File</label>');

        // Hide by shifting to the left so we
        // can still trigger events
        $file.css({
          position: 'absolute',
          left: '-9999px'
        });

        $wrap.insertAfter( $file )
          .append( $file, $input, ( isIE ? $label : $button ) );

        // Prevent focus
        $file.attr('tabIndex', -1);
        $button.attr('tabIndex', -1);

        $button.click(function () {
          $file.focus().click(); // Open dialog
        });

        $file.change(function() {

          var files = [], fileArr, filename;

          // If multiple is supported then extract
          // all filenames from the file array
          if ( multipleSupport ) {
            fileArr = $file[0].files;
            for ( var i = 0, len = fileArr.length; i < len; i++ ) {
              files.push( fileArr[i].name );
            }
            filename = files.join(', ');

          // If not supported then just take the value
          // and remove the path to just show the filename
          } else {
            filename = $file.val().split('\\').pop();
          }

          $input.val( filename ) // Set the value
            .attr('title', filename) // Show filename in title tootlip
            .focus(); // Regain focus

        });

        $input.on({
          blur: function() { $file.trigger('blur'); },
          keydown: function( e ) {
            if ( e.which === 13 ) { // Enter
              if ( !isIE ) { $file.trigger('click'); }
            } else if ( e.which === 8 || e.which === 46 ) { // Backspace & Del
              // On some browsers the value is read-only
              // with this trick we remove the old input and add
              // a clean clone with all the original events attached
              $file.replaceWith( $file = $file.clone( true ) );
              $file.trigger('change');
              $input.val('');
            } else if ( e.which === 9 ){ // TAB
              return;
            } else { // All other keys
              return false;
            }
          }
        });

      });

    };

    // Old browser fallback
    if ( !multipleSupport ) {
      $( document ).on('change', 'input.customfile', function() {

        var $this = $(this),
          // Create a unique ID so we
          // can attach the label to the input
          uniqId = 'customfile_'+ (new Date()).getTime(),
          $wrap = $this.parent(),

          // Filter empty input
          $inputs = $wrap.siblings().find('.file-upload-input')
            .filter(function(){ return !this.value }),

          $file = $('<input type="file" id="'+ uniqId +'" name="'+ $this.attr('name') +'"/>');

        // 1ms timeout so it runs after all other events
        // that modify the value have triggered
        setTimeout(function() {
          // Add a new input
          if ( $this.val() ) {
            // Check for empty fields to prevent
            // creating new inputs when changing files
            if ( !$inputs.length ) {
              $wrap.after( $file );
              $file.customFile();
            }
          // Remove and reorganize inputs
          } else {
            $inputs.parent().remove();
            // Move the input so it's always last on the list
            $wrap.appendTo( $wrap.parent() );
            $wrap.find('input').focus();
          }
        }, 1);

      });
    }

  }(jQuery));

  $('input[type=file]').customFile();


  // CLOSED IDEA
  var current_menu_close_idea = $('.close-idea-listmenu > li:first-child');
  var menu_list = 1;
  var menu_content = 1;
  var numCloseIdea = $('.close-idea-listmenu > li').size();
  $('.close-idea-listmenu > li').click(function() {
    $('.close-idea-listmenu li').removeClass('active');
    current_menu_close_idea.removeClass('active');
    //$('.close-idea-listmenu > li:nth-child(' + menu_list + ') > label').css('opacity','1');
    current_menu_close_idea = $(this);
    menu_list = $(this).index() + 1;
    current_menu_close_idea.addClass('active');

    $('.menu-content:nth-of-type(' + menu_content + ')').css('display','none');
    menu_content = $(this).index() + 1;
    if(menu_content < numCloseIdea){
      $('.btn-submit').css('display','none');
      $('.btn-next').css('display','block');
      $('button.btn-validate').attr('disabled', '');
      $('button.btn-validate').css({"background-color":"#b8b8b8", "color":"#FFF"});
    }
    if(menu_content === numCloseIdea){
      $('.btn-submit').css('display','block');
      $('.btn-next').css('display','none');
      $('button.btn-validate').removeAttr('disabled');
      $('button.btn-validate').css({"background-color":"#fdcf2f", "color":"#FFF"});
    }
    $('.menu-content:nth-of-type(' + menu_content + ')').css('display','block');
    formComplete();
  });

  $('.btn-next').click(function() {
    $('.menu-content:nth-of-type(' + menu_content + ')').css('display','none');
    $('.close-idea-listmenu > li:nth-of-type(' + menu_content + ')').removeClass('active');
    menu_content = menu_content + 1;
    if(menu_content < numCloseIdea){
      $('.btn-submit').css('display','none');
      $('.btn-next').css('display','block');
      $('button.btn-validate').attr('disabled', '');
      $('button.btn-validate').css({"background-color":"#b8b8b8", "color":"#FFF"});
    }
    if(menu_content === numCloseIdea){
      $('.btn-submit').css('display','block');
      $('.btn-next').css('display','none');
      $('button.btn-validate').removeAttr('disabled');
      $('button.btn-validate').css({"background-color":"#fdcf2f", "color":"#FFF"});
    }
    $('.menu-content:nth-of-type(' + menu_content + ')').css('display','block');
    $('.close-idea-listmenu > li:nth-of-type(' + menu_content + ')').addClass('active');
    formComplete();
  });


  $('.btn-delete ').click(function(){
    var list_sale_checked = [];
    for(var i = 2; i <= $('tr').size(); i++){
      var n = $('tr:nth-child(' + i + ') > td > .list-checkbox:checked').parents('tr').index() + 1;
      list_sale_checked.push(n);
      // alert(n);
    }
    for(var j = list_sale_checked.length - 1; j >= 0; j--){
      $('tr:nth-child(' + list_sale_checked[j] + ')').remove();
    }
  });

  var current_idea_stage = $('.list-current > li:first-child');
  $('.list-current > li').click(function() {
    current_idea_stage.removeClass('active');
    current_idea_stage = $(this);
    current_idea_stage.addClass('active');
    formComplete();
  });

  $('#idea_business_idea_attributes_customer_analysis_attributes_region_').selectize({
      maxItems: 20
  });

  $('#add-business-teams').click(function(){
    $('.add_fields').trigger('click');
  });

  $('#add-competitors').click(function(){
    $('.competitors-scenery .add_fields').trigger('click');
  });

  $('#add-competitors').click(function(){
    $('.competator-content .add_fields').trigger('click');
    $('.competator-content').css('border','1px solid #fdcf2f');
    $('.competator-content .nested-fields .child-team-row-form').removeClass('hide');
    $('.competator-content .nested-fields .child-team-row').addClass('hide');
    $('.child-team-row-form').css({'border':'none', 'padding-left':'0px', 'padding-bottom':'0px'});
  });

  $('#idea_business_idea_attributes_business_potencial_attributes_term_number').on('change', function(){
    $('select[name="idea[business_idea_attributes][business_potencial_attributes][revenue_type]"]').val('');
  });
  $('select[name="idea[business_idea_attributes][business_potencial_attributes][revenue_type]"]').on('change', function(){
    //$('.list-sales').addClass('hide');
    val = $(this).val();
    var term = parseInt($('#idea_business_idea_attributes_business_potencial_attributes_term_number').val());
    switch (val){
      case '1' :
        $('h4.params-1').html('Sales in Number of units <label>Projected numbers starts from next month. Allows only number. (No of units)</label>');
        $('h4.params-2').html('Prices per each sale <label>Projected numbers starts from next month. Allows only number. (Cost/UNIT)</label>');
        $('.params-2').show();
        $('.params-3').hide();
        createForm(term);
        $('#perUnit').modal('show');
        $('#per-unit-save').on('click', function(event){
          event.preventDefault();
          savePerUnit();
          $('#perUnit').modal('hide');
        });
        $('#perUnit button.params-1').trigger('click');
        break;
      case '2' :
        $('h4.params-1').html('Billable hours');
        $('h4.params-2').html('Hourly Rate');
        $('.params-2').show();
        $('.params-3').hide();
        createForm(term);
        $('#perUnit').modal('show');
        $('#per-unit-save').on('click', function(event){
          event.preventDefault();
          savePerHour();
          $('#perUnit').modal('hide');
        });
        $('#perUnit button.params-1').trigger('click');
        break;
      case '3' :
        $('.params-3, .params-1, .params-2').show();
        $('h4.params-1').html('No of Accounts');
        $('h4.params-2').html('Charges');
        $('h4.params-3').html('Churn Rate');
        createForm(term);
        $('#perUnit').modal('show');
        $('#per-unit-save').on('click', function(event){
          event.preventDefault();
          saveRecurring();
          $('#perUnit').modal('hide');
        });
        $('#perUnit button.params-1').trigger('click');
        break;
      case '4' :
        $('h4.params-1').html('Revenue');
        $('.params-2').hide();
        $('.params-3').hide();
        createForm(term);
        $('#perUnit').modal('show');
        $('#per-unit-save').on('click', function(event){
          event.preventDefault();
          saveOwnModel();
          $('#perUnit').modal('hide');
        });
        $('#perUnit button.params-1').trigger('click');
        break;
    }
  });

  $('#bnt-save-team-capabilities').click(function(){
    $('.team-capabilities .nested-fields').addClass('hide');
    $('.team-capabilities .nested-fields .child-team-row-form').addClass('hide');
    $('.team-capabilities .team-content').css('border','none');
    $('#view-team-capabilities').trigger('click');
  });

  $('#view-team-capabilities').click(function(){
    $('.team-capabilities .nested-fields').removeClass('hide');
    $('.team-capabilities .nested-fields .child-team-row').removeClass('hide');
    $('.team-capabilities .team-content').css('border','none');
    $('.team-capabilities .team-content .child-team-row:first').css('border','1px solid #fdcf2f');
  });

  $('#bnt-save-competitors-scenery').click(function(){
    $('.competitors-scenery .nested-fields').addClass('hide');
    $('.competitors-scenery .nested-fields .child-team-row-form').addClass('hide');
    $('.competitors-scenery .team-content').css('border','none');
    $('#view-competitors-scenery').trigger('click');
  });

  $('#view-competitors-scenery').click(function(){
    $('.competitors-scenery .nested-fields').removeClass('hide');
    $('.competitors-scenery .nested-fields .child-team-row').removeClass('hide');
    $('.competitors-scenery .team-content').css('border','none');
    $('.competitors-scenery .team-content .child-team-row:first').css('border','1px solid #fdcf2f');
  });

  $('#bnt-save-competitors-fund').click(function(){
    $('.competator-content .nested-fields').addClass('hide');
    $('.competator-content .nested-fields .child-team-row-form').addClass('hide');
    $('.competator-content').css('border','none');
    $('#view-competitors-fund').trigger('click');
  });

  $('#view-competitors-fund').click(function(){
    $('.competator-content .nested-fields').removeClass('hide');
    $('.competator-content .nested-fields .child-team-row').removeClass('hide');
    $('.competator-content').css('border','none');
    $('.competator-content #competitor_teams .child-team-row').css('border','1px solid #fdcf2f');
  });

  $('h4.chart-go-to').click(function(){
    if(allPer < 70){
      $('#validate').modal('hide');
    }else{
      $('#validate').modal('hide');
      // Submit form
      //event.preventDefault();
      // var valuesToSubmit = $('.form-close-idea').serialize();
      //var formData = document.getElementsByClassName('.form-close-idea');
      var form = $('form')[1];
      var valuesToSubmit = new FormData(form);
      $.ajax({
        type: "POST",
        url: $('.form-close-idea').attr('action'), //sumbits it to the given url of the form
        data: valuesToSubmit,
        contentType: false,
        processData: false,
        dataType: "JSON" // you want a difference between normal and ajax-calls, and json is standard
      }).success(function(json){
        if (json.location){
          window.location.href = json.location;
        }
        else{
          console.log("success", json);
          console.log(json.idea_id);
          //var r = $.parseJSON(json);
          $('input[name="order[idea_id]"]').val(json.idea_id);
        }
      });
      $('#myModal').modal('show');
    }
  });
  // Fix input type is number but still enter 'e' .
  $('input[type="number"]').numeric();

});
var tenForm = 0;
var allPer = 0;
var completion = [];
var old_type = '';
var old_html = '';
var oldPerValue = [];
var oldPerValue2 = [];
var oldPerValue3 = [];
var submit = false;
function validateForm(tab){
  var is_nil = 0;
  var total = 0;
  try{
    $('form.form-close-idea .'+ tab +' input').each(function(){
      type = $(this).attr('type');
      var attr = $(this).attr('min');
      if(type != 'hidden' && type != 'checkbox' && type != 'radio' && typeof attr == typeof undefined && attr == false ){
        if($(this).prop('required')){
          total++;
          if($(this).val() == ''){
            is_nil++;
          }
        }
      }
    });
  }catch(err){}
  try{
    $('form.form-close-idea .'+ tab +' select').each(function(){
      total++;
      if($(this).val() == ''){
        is_nil++;
      }
    });
  }catch(err){}
  try{
    $('form.form-close-idea .'+ tab +' textarea').each(function(){
      if($(this).prop('required')){
        total++;
        if($(this).val() == '' || $(this).val().length < 80 || $(this).val().length > 400){
          is_nil++;
        }
      }
    });
  }catch(err){}
  if (tab == 'primary-details'){
    try {
      if(parseInt($('.primary-details').find('input[name="idea[business_idea_attributes][ip_patent]"]:checked').val()) != 30)
      {
        total++;
        if ($('.primary-details').find('#idea_business_idea_attributes_register_number').val() == ''){
          is_nil++;
        }
      }
    }catch(err){}
    total = total + 2;
    is_nil = is_nil + 1;
    if($('input[name="idea[business_idea_attributes][idea_stage]"]:checked').length > 0){
      is_nil--;
    }
  }
  if(tab == 'stage-analysis'){
    total = total + 4;
    is_nil = is_nil + 4;
    if($('input[name="idea[business_idea_attributes][motivation_vision]"]:checked').length > 0){
      is_nil--;
    }
    if($('input[name="idea[business_idea_attributes][year_exp]"]:checked').length > 0){
      is_nil--;
    }
    if($('input[name="idea[business_idea_attributes][startup_business]"]:checked').length > 0){
      is_nil--;
    }
    if($('input[name="idea[business_idea_attributes][business_model]"]:checked').length > 0){
      is_nil--;
    }
  }
  if(tab == 'team-capabilities'){
    total = total + 2;
    is_nil = is_nil + 2;
    if($('input[name="idea[business_idea_attributes][team_cappabilitie_attributes][crucial_skills]"]:checked').length > 0){
      is_nil--;
    }
    if($('input[name="idea[business_idea_attributes][team_cappabilitie_attributes][team_attributes]"]:checked').length > 0){
      is_nil--;
    }
  }
  if(tab == 'market-analysis'){
    total = total + 5;
    is_nil = is_nil + 5;
    if($('input[name="idea[business_idea_attributes][market_analysis_attributes][is_new]"]:checked').length > 0){
      is_nil--;
    }
    if($('input[name="idea[business_idea_attributes][market_analysis_attributes][have_major]"]:checked').length > 0){
      is_nil--;
    }
    if($('input[name="idea[business_idea_attributes][market_analysis_attributes][market_trend]"]:checked').length > 0){
      is_nil--;
    }
    if($('input[name="idea[business_idea_attributes][market_analysis_attributes][market_channels]"]:checked').length > 0){
      is_nil--;
    }
    if($('input[name="idea[business_idea_attributes][market_analysis_attributes][market_size]"]:checked').length > 0){
      is_nil--;
    }
  }
  if(tab == 'customer-analysis'){
    is_nil = is_nil + 1;
    if($('input[name="idea[business_idea_attributes][customer_analysis_attributes][big_customer]"]:checked').length > 0){
      is_nil--;
    }
    if($('select[name="idea[business_idea_attributes][customer_analysis_attributes][region][]"]').val() != null){
      is_nil--;
    }
  }
  if(tab == 'investment-scale'){
    total = total + 2;
    is_nil = is_nil + 2;
    if($('input[name="idea[business_idea_attributes][investment_scale_attributes][fund_already]"]:checked').length > 0){
      is_nil--;
    }
    if($('input[name="idea[business_idea_attributes][investment_scale_attributes][fund_like_to_invest]"]:checked').length > 0){
      is_nil--;
    }
  }
  /*if(tab == 'competitors-scenery'){
    total = total + 1;
    is_nil = is_nil + 1;
    if($('input[name="idea[business_idea_attributes][competitor_attributes][image]"]').val() != ''){
      is_nil--;
    }
  }*/
  if(tab == 'pitch-burns'){
    $('form.form-close-idea .'+ tab +' input').each(function(){
      type = $(this).attr('type');
      if(type == 'file' ){
        if($(this).prop('required')){
          total++;
          if($(this).val() == ''){
            is_nil++;
          }
        }
      }
    });
  }

  var per = (total - is_nil ) / total ;
  var c = Number((per).toFixed(2)) * 100;
  if ( c >= 100 ) {
    completion.push(true);
    c = 100;
  }else{
    completion.push(false);
  }
  return c.toFixed(2);
}

var primary_details, stage_analysis, team_capabilities, competitors_scenery, market_analysis, customer_analysis, investment_scale, business_potencial, pitch_burns, exit_strategy;

// Percentage for section
function percentageSction(section){
  var c = 0;
  if(section == 'primary-details'){
    stage = $('input[name="idea[business_idea_attributes][idea_stage]"]:checked').length > 0 ? parseInt($('input[name="idea[business_idea_attributes][idea_stage]"]:checked').val()) : 0;
    ip_patent = $('input[name="idea[business_idea_attributes][ip_patent]"]:checked').length > 0 ? parseInt($('input[name="idea[business_idea_attributes][ip_patent]"]:checked').val()) : 0;
    sum = stage + ip_patent;
    per = sum / 200;
  }else if(section == 'stage-analysis'){
    motivation_vision_arr = [0, 60, 50, 75, 100, 30];
    year_exp_arr = [50, 65, 75, 85, 95];
    startup_business_arr = [0, 50, 70, 80, 75, 65];
    business_model_arr = [0, 100, 100, 100, 0, 100];

    motivation_vision = $('input[name="idea[business_idea_attributes][motivation_vision]"]:checked').length > 0 ? motivation_vision_arr[parseInt($('input[name="idea[business_idea_attributes][motivation_vision]"]:checked').val())] : 0;
    year_exp = $('input[name="idea[business_idea_attributes][year_exp]"]:checked').length > 0 ? year_exp_arr[parseInt($('input[name="idea[business_idea_attributes][year_exp]"]:checked').val())] : 0;
    startup_business = $('input[name="idea[business_idea_attributes][startup_business]"]:checked').length > 0 ? startup_business_arr[parseInt($('input[name="idea[business_idea_attributes][startup_business]"]:checked').val())] : 0;
    business_model = $('input[name="idea[business_idea_attributes][business_model]"]:checked').length > 0 ? business_model_arr[parseInt($('input[name="idea[business_idea_attributes][business_model]"]:checked').val())] : 0;
    sum = motivation_vision + year_exp + startup_business + business_model;
    per = sum / 400;
  }else if(section == 'team-capabilities'){
    crucial_skills_arr = [0, 90, 60, 70, 95, 35];
    crucial_skills = $('input[name="idea[business_idea_attributes][team_cappabilitie_attributes][crucial_skills]"]:checked').length > 0 ? crucial_skills_arr[parseInt($('input[name="idea[business_idea_attributes][team_cappabilitie_attributes][crucial_skills]"]:checked').val())] : 0;
    team_attributes_arr = [0, 90, 70, 95, 65, 50];
    team_attributes = $('input[name="idea[business_idea_attributes][team_cappabilitie_attributes][team_attributes]"]:checked').length > 0 ? team_attributes_arr[parseInt($('input[name="idea[business_idea_attributes][team_cappabilitie_attributes][team_attributes]"]:checked').val())] : 0;
    sum = crucial_skills + team_attributes;
    per = sum / 200;
  }else if(section == 'market-analysis'){
    market_trend_arr = [0, 40, 60, 75, 90, 10];
    market_channels_arr = [0, 70, 60, 65, 80, 75];
    market_size_arr = [0, 60, 70, 80, 90, 100];
    market_trend = $('input[name="idea[business_idea_attributes][market_analysis_attributes][market_trend]"]:checked').length > 0 ? market_trend_arr[parseInt($('input[name="idea[business_idea_attributes][market_analysis_attributes][market_trend]"]:checked').val())] : 0;
    market_channels = $('input[name="idea[business_idea_attributes][market_analysis_attributes][market_channels]"]:checked').length > 0 ? market_channels_arr[parseInt($('input[name="idea[business_idea_attributes][market_analysis_attributes][market_channels]"]:checked').val())] : 0;
    market_size = $('input[name="idea[business_idea_attributes][market_analysis_attributes][market_size]"]:checked').length > 0 ? market_size_arr[parseInt($('input[name="idea[business_idea_attributes][market_analysis_attributes][market_size]"]:checked').val())] : 0;
    sum = market_trend + market_channels + market_size;
    per = sum / 300;
  }else if(section == 'customer-analysis'){
    big_customer_arr = [0, 50, 60, 70, 80, 90];
    big_customer = $('input[name="idea[business_idea_attributes][customer_analysis_attributes][big_customer]"]:checked').length > 0 ? big_customer_arr[parseInt($('input[name="idea[business_idea_attributes][customer_analysis_attributes][big_customer]"]:checked').val())] : 0;
    per = big_customer / 100;
  }else if(section == 'investment-scale'){
    fund_already_arr = {10 : 40, 20 : 45, 30 : 50, 40 : 55, 50 : 60, 60 : 65, 70 : 70, 0 : 10 };
    fund_like_to_invest_arr = {10 : 40, 20 : 45, 30 : 50, 40 : 55, 50 : 60, 60 : 65, 70 : 70, 0 : 10 };
    fund_already = $('input[name="idea[business_idea_attributes][investment_scale_attributes][fund_already]"]:checked').length > 0 ? fund_already_arr[parseInt($('input[name="idea[business_idea_attributes][investment_scale_attributes][fund_already]"]:checked').val())] : 0;
    fund_like_to_invest = $('input[name="idea[business_idea_attributes][investment_scale_attributes][fund_like_to_invest]"]:checked').length > 0 ? fund_like_to_invest_arr[parseInt($('input[name="idea[business_idea_attributes][investment_scale_attributes][fund_like_to_invest]"]:checked').val())] : 0;
    sum = fund_already + fund_like_to_invest;
    per = sum / 200;
  }else if(section == 'business-potencial'){
    per = 0;
  }else if(section == 'competitors-scenery'){
    per = 0;
  }else if(section == 'pitch-burns'){
    per = 0;
  }else if(section == 'exit-strategy'){
    per = 0;
  }
  c = Number((per).toFixed(2)) * 100;
  tenForm = tenForm + c;
  return c.toFixed(0);
}

function formComplete() {
  completion = [];
  tenForm = 0;
  validateForm('primary-details') == 100  ? checkComplete(1) : checkComplete(1, false);
  validateForm('stage-analysis') == 100  ? checkComplete(2) : checkComplete(2, false);
  validateForm('team-capabilities') == 100  ? checkComplete(3) : checkComplete(3, false);
  validateForm('market-analysis') == 100  ? checkComplete(4) : checkComplete(4, false);
  validateForm('customer-analysis') == 100  ? checkComplete(5) : checkComplete(5, false);
  validateForm('investment-scale') == 100  ? checkComplete(6) : checkComplete(6, false);
  validateForm('business-potencial') == 100  ? checkComplete(7) : checkComplete(7, false);
  validateForm('competitors-scenery') == 100  ? checkComplete(8) : checkComplete(8, false);
  validateForm('pitch-burns') == 100  ? checkComplete(9) : checkComplete(9, false);
  validateForm('exit-strategy') == 100  ? checkComplete(10) : checkComplete(10, false);
  primary_details  = percentageSction('primary-details');
  stage_analysis = percentageSction('stage-analysis');
  team_capabilities = percentageSction('team-capabilities');
  market_analysis = percentageSction('market-analysis');
  customer_analysis = percentageSction('customer-analysis');
  investment_scale = percentageSction('investment-scale');
  business_potencial = percentageSction('business-potencial');
  competitors_scenery = percentageSction('competitors-scenery');
  pitch_burns = percentageSction('pitch-burns');
  exit_strategy = percentageSction('exit-strategy');
  p = tenForm / 600;
  allPer = (Number((p).toFixed(2)) * 100).toFixed(0);
}

function checkComplete(li, val){
  if (val != false){
    $('.close-idea-listmenu > li:nth-child(' + li + ') > label').css('opacity','1');
  }else{
    $('.close-idea-listmenu > li:nth-child(' + li + ') > label').css('opacity','0');
  }
}

var monthNames = ["January", "February", "March", "April", "May", "June",
  "July", "August", "September", "October", "November", "December"
  ];

function createForm(y){
  var d = new Date();
  var m = d.getMonth();
  var m2 = d.getMonth();
  y = (typeof y == "undefined") ? 1 : y ;
  $listmonth = $('#perUnit .list-month#params-1');
  var html = '';
  var j = 0;
  var _type = parseInt($('#idea_business_idea_attributes_business_potencial_attributes_revenue_type').val());
  while(j < y)
  {
    html += '<div class="list-month-content container-fluid">';
    html += '<div class="month container-fluid">';
    for(var i = 0; i < 12; i++) {
      html += '<div class="month-element">';
      if (_type == 2){
        html += '<input class="per-unit-sale hours" placeholder="'+monthNames[m]+'" type="text">';
      }else{
        html += '<input class="per-unit-sale" placeholder="'+monthNames[m]+'" min="0" type="number">';
      }
      html += '</div>';
      m++;
      if(m > 11){m = 0;}
    }
    html += '</div>';
    html += '<input class="total" disabled placeholder="Total #" type="text">';
    html += '</div>';
    j++;
  }
  $listmonth.html(html).removeClass('hide');
  param1_keyup(_type);

  var html2 = '';
  var j = 0;
  while(j < y)
  {
    html2 += '<div class="list-month-content container-fluid">';
    html2 += '<div class="month container-fluid">';
    for(var i = 0; i < 12; i++) {
      html2 += '<div class="month-element">';
      html2 += '<input class="per-unit-price" placeholder="'+monthNames[m2]+'" min="0" type="number">';
      html2 += '</div>';
      m2++;
      if(m2 > 11){m2 = 0;}
    }
    html2 += '</div>';
    html2 += '<input id="total-per-price" class="total" disabled placeholder="Total #" type="number">';
    html2 += '</div>';
    j++;
  }

  $listmonth2 = $('#perUnit .list-month#params-2');
  $listmonth2.html(html2);
  param2_keyup(_type);

  var html3 = '';
  var j = 0;
  while(j < y)
  {
    html3 += '<div class="list-month-content container-fluid">';
    html3 += '<div class="month container-fluid">';
    for(var i = 0; i < 12; i++) {
      html3 += '<div class="month-element">';
      html3 += '<input class="input-params-3" placeholder="'+monthNames[m2]+'" min="0" type="number">';
      html3 += '</div>';
      m2++;
      if(m2 > 11){m2 = 0;}
    }
    html3 += '</div>';
    html3 += '<input id="total-params-3" class="total" disabled placeholder="Total #" type="number">';
    html3 += '</div>';
    j++;
  }
  $listmonth3 = $('#perUnit .list-month#params-3');
  $listmonth3.html(html3);
  param3_keyup(_type);
  // Active param tab
  activeParams();

  $('#per-unit-clear').click(function(){
    $('input.per-unit-sale, input.per-unit-price, input.total').val('');
  });
  // Fix input type is number but still enter 'e' .
  $('input[type="number"]').numeric();
  // Show tooltip when focus hours text field
  $('input.hours').tooltip({'trigger':'focus', 'title': 'Format "HH:MM"'});
  // Validate when keyup hours text field
  $('input.hours').on('keyup', function(){
    var validate = validateTimeForPerHour($(this).val());
    if(validate == false){
      $(this).css({"color":"red"});
    }else{
      $(this).css({"color":"#a5a5a5"});
    }
  });

}
// Validate format HH:MM
function validateTimeForPerHour(time) {
  if (time.match(/^[0-9]{2,3}:[0-9]{2}$/)) {
    return true;
  } else {
    return false;
  }
}
// Convert minutes to String
function minutesToStr(minutes) {
   var hours = leftPad(Math.floor(Math.abs(minutes) / 60));
   var minutes = leftPad(Math.abs(minutes) % 60);
   return hours +':'+minutes;

}

function leftPad(number) {
  return ((number < 10 && number >= 0) ? '0' : '') + number;
}

function savePerUnit(){
  var _type = parseInt($('#idea_business_idea_attributes_business_potencial_attributes_revenue_type').val());
  old_type = _type;
  $('.list-sales > h4').text('Sales in Number of Units');
  var perUnit = $('#perUnit input.per-unit-sale');
  var perUnitValue = {};
  var i = 1;
  perUnit.each(function(){
    if(_type == 2){
      if(validateTimeForPerHour($(this).val()) == true){
        time = $(this).val().split(":");
        h = parseInt(time[0]);
        m = parseInt(time[1]);
        value = h * 60 + m;
      }else{
        value = 0;
      }
    }else{
      if($(this).val() == ''){
        value = 0;
      }else{
        value = parseInt($(this).val());
      }
    }
    perUnitValue[i] = value;
    oldPerValue[i] = $(this).val();
    i++;
  });
  var perUnit2 = $('#perUnit input.per-unit-price');
  var perUnitValue2 = {};
  var i = 1;
  perUnit2.each(function(){
    if($(this).val() == ''){
      value2 = 0;
    }else{
      value2 = parseInt($(this).val());
    }
    perUnitValue2[i] = value2;
    oldPerValue2[i] = $(this).val();
    i++;
  });
  var perUnit3 = $('#perUnit input.input-params-3');
  var perUnitValue3 = {};
  var i = 1;
  perUnit3.each(function(){
    if($(this).val() == ''){
      value3 = 0;
    }else{
      value3 = parseInt($(this).val());
    }
    perUnitValue3[i] = value3;
    oldPerValue3[i] = $(this).val();
    i++;
  });

  $('#idea_business_idea_attributes_business_potencial_attributes_per_unit_attributes_sale').val(JSON.stringify(perUnitValue));
  $('#idea_business_idea_attributes_business_potencial_attributes_per_unit_attributes_price').val(JSON.stringify(perUnitValue2));
  $('#idea_business_idea_attributes_business_potencial_attributes_per_hour_attributes_billable').val(JSON.stringify(perUnitValue));
  $('#idea_business_idea_attributes_business_potencial_attributes_per_hour_attributes_hour_rate').val(JSON.stringify(perUnitValue2));
  $('#idea_business_idea_attributes_business_potencial_attributes_own_model_attributes_revenue').val(JSON.stringify(perUnitValue));
  $('#idea_business_idea_attributes_business_potencial_attributes_recurring_attributes_no_account').val(JSON.stringify(perUnitValue));
  $('#idea_business_idea_attributes_business_potencial_attributes_recurring_attributes_charge').val(JSON.stringify(perUnitValue2));
  $('#idea_business_idea_attributes_business_potencial_attributes_recurring_attributes_churn_rate').val(JSON.stringify(perUnitValue3));
  var k = 1;
  var perTotal = 0;
  var perTotal2 = 0;
  var perTotal3 = 0;
  var html3 = '';
  var years = 1;
  var d = new Date();
  var m3 = d.getMonth();
  html3 += '<tr>';
  for(var n = 0 ; n < 12 ; n++){
    html3 += '<th>'+monthNames[m3]+'</th>';
    m3++;
    if (m3 > 11){m3 = 0;}
  }
  html3 += '<th>Total #</th>';
  html3 += '<th>Duration</th>';
  html3 += '</tr>';
  perUnit.each(function(){
    if($(this).val() == ''){
      value = 0;
    }else{
      if(_type == 2){
        value = $(this).val();
      }else{
        value = parseInt($(this).val());
      }
    }
    if(k == 1 || k == 13|| k == 25 || k == 37 || k == 49){
      html3 += '<tr>';
    }
    if(_type == 1 ){
      html3 += '<td>'+value + '-' + perUnitValue2[k] +'</td>';
    }else if(_type == 2){
      html3 += '<td>'+value + '-' + perUnitValue2[k] +'</td>';
    }else if (_type == 4){
      html3 += '<td>'+value+'</td>';
    }else {
      html3 += '<td>'+value + '-' + perUnitValue2[k] + '-' + perUnitValue3[k] +'</td>';
    }
    if(_type == 1 || _type == 3 || _type == 4){
      perTotal = perTotal + value;
    }else{
      if(perTotal == 0){
        s2 = 0;
      }else{
        perTotal = perTotal.split(":");
        h = parseInt(perTotal[0]);
        m = parseInt(perTotal[1]);
        s2 = h * 60 + m;
      }

      if(value != 0){
        s1 = value.split(":");
        h = parseInt(s1[0]);
        m = parseInt(s1[1]);
        s1 = h * 60 + m;
        s3 = s1 + s2;
      }else{
        s3 = s2;
      }
      perTotal = minutesToStr(s3);
    }

    perTotal2 = perTotal2 + perUnitValue2[k];
    perTotal3 = perTotal3 + perUnitValue3[k];
    if (k == 12 || k == 24 || k == 36 || k == 48 || k == 60){
      if (_type == 1 || _type == 2){
        html3 += '<td>'+perTotal + '-' + perTotal2 +'</td>';
      }else if (_type == 4){
        html3 += '<td>'+perTotal + '</td>';
      }else{
        html3 += '<td>'+perTotal + '-' + perTotal2 + '-' + perTotal3 +'</td>';
      }
      html3 += '<td>Year : '+years+'</td>';
      html3 += '</tr>';
      perTotal = 0;
      perTotal2 = 0;
      perTotal3 = 0;
      years++;
    }
    k++;
  });
  $('.table-list').html(html3);
  $('.list-sales').removeClass('hide');
  old_html = $('#perUnit .modal-body').html();
  $('input[type="text"], input[type="number"], textarea').keyup(function(){
    submit = false;
  });
}

function savePerHour() {
  savePerUnit();
  $('.list-sales > h4').text('Billable hours')
  $('#idea_business_idea_attributes_business_potencial_attributes_per_unit_attributes_sale').val('{}');
  $('#idea_business_idea_attributes_business_potencial_attributes_per_unit_attributes_price').val('{}');
  $('#idea_business_idea_attributes_business_potencial_attributes_own_model_attributes_revenue').val('{}');
  $('#idea_business_idea_attributes_business_potencial_attributes_recurring_attributes_no_account').val('{}');
  $('#idea_business_idea_attributes_business_potencial_attributes_recurring_attributes_charge').val('{}');
  $('#idea_business_idea_attributes_business_potencial_attributes_recurring_attributes_churn_rate').val('{}');
  old_html = $('#perUnit .modal-body').html();
}

function saveOwnModel() {
  savePerUnit();
  $('.list-sales > h4').text('Revenue')
  $('#idea_business_idea_attributes_business_potencial_attributes_per_unit_attributes_sale').val('{}');
  $('#idea_business_idea_attributes_business_potencial_attributes_per_unit_attributes_price').val('{}');
  $('#idea_business_idea_attributes_business_potencial_attributes_per_hour_attributes_billable').val('{}');
  $('#idea_business_idea_attributes_business_potencial_attributes_per_hour_attributes_hour_rate').val('{}');
  $('#idea_business_idea_attributes_business_potencial_attributes_recurring_attributes_no_account').val('{}');
  $('#idea_business_idea_attributes_business_potencial_attributes_recurring_attributes_charge').val('{}');
  $('#idea_business_idea_attributes_business_potencial_attributes_recurring_attributes_churn_rate').val('{}');
  old_html = $('#perUnit .modal-body').html();
}

function saveRecurring() {
  savePerUnit();
  $('.list-sales > h4').text('No of Accounts');
  $('#idea_business_idea_attributes_business_potencial_attributes_per_unit_attributes_sale').val('{}');
  $('#idea_business_idea_attributes_business_potencial_attributes_per_unit_attributes_price').val('{}');
  $('#idea_business_idea_attributes_business_potencial_attributes_per_hour_attributes_billable').val('{}');
  $('#idea_business_idea_attributes_business_potencial_attributes_per_hour_attributes_hour_rate').val('{}');
  $('#idea_business_idea_attributes_business_potencial_attributes_own_model_attributes_revenue').val('{}');
  old_html = $('#perUnit .modal-body').html();
}

function drawChart() {
  formComplete();
  $('.primary-details-chart > label').text(primary_details);
  $('.stage-analysis-chart > label').text(stage_analysis);
  $('.team-capabilities-chart > label').text(team_capabilities);
  $('.market-analysis-chart > label').text(market_analysis);
  $('.customer-analysis-chart > label').text(customer_analysis);
  $('.investment-scale-chart > label').text(investment_scale);
  $('.business-potencial-chart > label').text(business_potencial);
  $('.competitors-scenery-chart > label').text(competitors_scenery);
  $('.pitch-burns-chart > label').text(pitch_burns);
  $('.exit-strategy-chart > label').text(exit_strategy);
  $('.percentage-circle > .txt-percentage > lable').text(allPer);
  $('.percentage-circle').prev().find('label').text('\xa0' + allPer);
  if (allPer < 70 ){
    $('h4.chart-go-to').css('opacity','0.5');
  }
  //Change color percentage
  var numPercentage = $('.modal-validation-element').size();
  for(var i = 1; i <= numPercentage; i++){
    var percentage_validate = $('.modal-validation-element:nth-child('+ i + ') > .txt-percentage > label').text();
    if(percentage_validate >= 50){
      $('.modal-validation-element:nth-child('+ i + ') > .percentage > .percentage-above').css({'background':'#18a292','width':percentage_validate + '%'});
    }
    if(percentage_validate < 50){
      $('.modal-validation-element:nth-child('+ i + ') > .percentage > .percentage-above').css({'background':'#fa5429','width':percentage_validate + '%'});
    }
  }
  //$('.percentage-circle-current').css({'border-right':'50px solid transparent'});

  //Change color percentage circle
  var percentage_circle = $('.modal-footer-validate > h4 > label').text();

  //Percentage Circle Right
  if(percentage_circle <= 12.5){
    var deg = percentage_circle * 4;
    $('.percentage-circle-current').css({'border-right': deg + 'px solid transparent', 'border-top': '50px solid red'});
  }
  if(percentage_circle > 12.5 && percentage_circle < 25){
    var deg = ((percentage_circle - 12.5) * 12) + 50;
    $('.percentage-circle-current').css({'border-right': deg + 'px solid transparent', 'border-top': '50px solid red'});
  }
  if(percentage_circle == 25){
    $('.percentage-circle-current').css({'border-right': '50px solid red', 'border-top': '50px solid red'});
  }
  if(percentage_circle > 25 && percentage_circle <= 37.5){
    var deg = (percentage_circle - 25) * 4;
    $('.percentage-circle-current').css({'border-right': '50px solid red','border-bottom': deg + 'px solid transparent', 'border-top': '50px solid red'});
  }
  if(percentage_circle == 50){
    $('.percentage-circle-current').css({'border-right': '50px solid red','border-bottom': '50px solid red', 'border-top': '50px solid red'});
  }


  //Percentage Circle Left
  if(percentage_circle > 50 && percentage_circle < 65){
    var deg = (percentage_circle - 50) * 4;
    $('.percentage-circle-current').css({'border-right': '50px solid red','border-bottom': '50px solid red', 'border-top': '50px solid red'});
    $('.percentage-circle-current-left').css({'border-left': deg + 'px solid transparent', 'border-bottom': '50px solid red'});
  }
  if(percentage_circle >= 65 && percentage_circle < 75){
    var deg = (percentage_circle - 50) * 4;
    $('.percentage-circle-current').css({'border-right': '50px solid white','border-bottom': '50px solid white', 'border-top': '50px solid white'});
    $('.percentage-circle-current-left').css({'border-left': deg + 'px solid transparent', 'border-bottom': '50px solid white'});
  }
  if(percentage_circle == 75){
    $('.percentage-circle-current').css({'border-right': '50px solid white','border-bottom': '50px solid white', 'border-top': '50px solid white'});
    $('.percentage-circle-current-left').css({'border-left': '50px solid white', 'border-bottom': '50px solid white'});
  }
  if(percentage_circle > 75 && percentage_circle < 100){
    var deg = (percentage_circle - 75) * 4;
    $('.percentage-circle-current').css({'border-right': '50px solid white','border-bottom': '50px solid white', 'border-top': '50px solid white'});
    $('.percentage-circle-current-left').css({'border-left': '50px solid white','border-top': deg + 'px solid transparent', 'border-bottom': '50px solid white'});
  }
  if(percentage_circle == 100){
    $('.percentage-circle-current').css({'border-right': '50px solid white','border-bottom': '50px solid white', 'border-top': '50px solid white'});
    $('.percentage-circle-current-left').css({'border-left': '50px solid white','border-top': '50px solid white', 'border-bottom': '50px solid white'});
  }
}

function activeParams() {
  // Active param tab
  $('#perUnit button.params-1').click(function(){
    $('#perUnit button.params-2').removeClass('active');
    $('#perUnit button.params-3').removeClass('active');
    $('.list-month').addClass('hide');
    $('.list-month#params-1').removeClass('hide');
    $(this).addClass('active');
    $('h4.params-2').addClass('hide');
    $('h4.params-1').removeClass('hide');
    $('h4.params-3').addClass('hide');
  });
  $('#perUnit button.params-2').click(function(){
    $('#perUnit button.params-1').removeClass('active');
    $('#perUnit button.params-3').removeClass('active');
    $('.list-month').addClass('hide');
    $('.list-month#params-2').removeClass('hide');
    $('h4.params-2').removeClass('hide');
    $('h4.params-1').addClass('hide');
    $('h4.params-3').addClass('hide');
    $(this).addClass('active');
  });
  $('#perUnit button.params-3').click(function(){
    $('#perUnit button.params-1').removeClass('active');
    $('#perUnit button.params-2').removeClass('active');
    $('.list-month').addClass('hide');
    $('.list-month#params-3').removeClass('hide');
    $('h4.params-2').addClass('hide');
    $('h4.params-1').addClass('hide');
    $('h4.params-3').removeClass('hide');
    $(this).addClass('active');
  });
}

function param1_keyup(_type) {
  $('.per-unit-sale').keyup(function(){
    var total = 0;
    $(this).parent().parent().find('.per-unit-sale').each(function(){
      if (_type == 2){
        if(validateTimeForPerHour($(this).val()) == true){
          if(total == 0){
            total = $(this).val();
          }else{
            time = $(this).val().split(":");
            h = parseInt(time[0]);
            m = parseInt(time[1]);
            s1 = h * 60 + m;
            total = total.split(":");
            h = parseInt(total[0]);
            m = parseInt(total[1]);
            s2 = h * 60 + m;
            s3 = s1 + s2;
            total = minutesToStr(s3);
          }
        }
      }else{
        if($(this).val() == ''){
          value = 0;
        }else{
          value = parseInt($(this).val());
        }
        total = total +value;
      }
    });
    $(this).parent().parent().next('.total').val(total);
  });
}

function param2_keyup(_type) {
  $('.per-unit-price').keyup(function(){
    var total = 0;
    $(this).parent().parent().find('.per-unit-price').each(function(){
      if($(this).val() == ''){
        value = 0;
      }else{
        value = parseInt($(this).val());
      }
      total = total +value;
    });
    $(this).parent().parent().next('.total').val(total);
  });
}

function param3_keyup(_type) {
  $('.input-params-3').keyup(function(){
    var total = 0;
    $(this).parent().parent().find('.input-params-3').each(function(){
      if($(this).val() == ''){
        value = 0;
      }else{
        value = parseInt($(this).val());
      }
      total = total +value;
    });
    $(this).parent().parent().next('.total').val(total);
  });
}

function renderOldModalForm(old_type){
  if(typeof old_type != typeof undefined){
    if (old_type != parseInt($('select[name="idea[business_idea_attributes][business_potencial_attributes][revenue_type]"]').val())) {
      $('#perUnit .modal-body').html(old_html);
      activeParams();
      $('select[name="idea[business_idea_attributes][business_potencial_attributes][revenue_type]"]').val(old_type);
      var i = 1;
      $('#perUnit input.per-unit-sale').each(function(){
        $(this).val(oldPerValue[i]);
        i++;
      });

      var j = 1;
      $('#perUnit input.per-unit-price').each(function(){
        $(this).val(oldPerValue2[j]);
        j++;
      });
      var k = 1;
      $('#perUnit input.input-params-3').each(function(){
        $(this).val(oldPerValue3[k]);
        k++;
      });
      param1_keyup(old_type);
      param2_keyup(old_type);
      param3_keyup(old_type);
      term = parseInt($('#idea_business_idea_attributes_business_potencial_attributes_term_number').val());
      try{
        $('.per-unit-sale:first').trigger('keyup');
        i = 1;
        while(i < term + 1){
          $($('.per-unit-sale')[i*12]).trigger('keyup');
          i++;
        }
      }catch(err){}
      try{
        $('.per-unit-price:first').trigger('keyup');
        i = 1;
        while(i < term + 1){
          $($('.per-unit-price')[i*12]).trigger('keyup');
          i++;
        }
      }catch(err){}
      try{
        $('.input-params-3:first').trigger('keyup');
         i = 1;
        while(i < term + 1){
          $($('.input-params-3')[i*12]).trigger('keyup');
          i++;
        }
      }catch(err){}
    }
  }
  $('#perUnit').modal('show');
  $('#perUnit button.params-1').trigger('click');
}

// Retrun tooltip title
function tooltipTitle(){
  var text = 'Minimum 80 characters to 400 characters maximum';
  return text;
}

function tooltipTitleSmall(){
  var text = 'Minimum 100 characters to 300 characters maximum';
  return text;
}

function tooltipTitleLarge(){
  var text = 'Minimum 100 characters to 600 characters maximum';
  return text;
}

function intrested(event, id){
  event.preventDefault();
  var url = "/api/idea/intrested/";
  $.ajax({
    url: url,
    type: 'POST',
    data: {id: id},
    beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
    success: function(res) {
      //$('h6.title2').next().remove();
      //$(res).insertAfter('h6.title2');
    },
    error: function(e) {
    }
  });
}

function deal(event, id){
  event.preventDefault();
  var url = "/api/idea/deal/";
  $.ajax({
    url: url,
    type: 'POST',
    data: {id: id},
    beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
    success: function(res) {
      //$('h6.title2').next().remove();
      //$(res).insertAfter('h6.title2');
    },
    error: function(e) {
    }
  });
}

function favorite(event, id){
  event.preventDefault();
  var url = "/api/idea/favorite/";
  $.ajax({
    url: url,
    type: 'POST',
    data: {id: id},
    beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
    success: function(res) {
      //$('h6.title2').next().remove();
      //$(res).insertAfter('h6.title2');
    },
    error: function(e) {
    }
  });
}


function sendRequest(url, data){
  var data = {
    "message[detail]": data[2].value,
    "message[receiver_id]": data[3].value,
    "message[idea_id]": data[4].value
  };
  $.ajax({
    url: url,
    type: 'POST',
    data: data,
    beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
    success: function(res) {

    },
    error: function(e) {
    }
  });
}

function unlike(event, id){
  intrested(event, id);
  $('#item-'+id).remove();
}
$('.under_contruction').on('change', function(){
  alert("aaa");
})