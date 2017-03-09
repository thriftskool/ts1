
function GetXmlHttpObject()
{
    var xmlHttp = null;
    try
    {
        xmlHttp = new XMLHttpRequest();
    }
    catch (e)
    {
        try
        {
            xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
        }
        catch (e)
        {
            xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
        }
    }
    return xmlHttp;
}

/*************UpdatePublish**********/

function UpdatePublish(module, tablename, fieldname, intglcode, othertable)
{
    xmlHttp = GetXmlHttpObject();
    if (xmlHttp == null)
    {
        alert("Your browser does not support XMLHTTP!");
        return;
    }


    var path = document.getElementById('tick-' + intglcode).src;
    var file_a = path.substring(path.lastIndexOf("/") + 1, path.length);
    var value;
    if (file_a == 'tick.png')
    {
        value = 'N';
    }
    else if (file_a == 'tick_cross.png')
    {
        value = 'Y';
    }
    if (othertable == '')
    {
        var url = BASE + "adminpanel/" + module + "/UpdatePublish?tablename=" + tablename + "&fieldname=" + fieldname + "&value=" + value + "&id=" + intglcode;
    }
    else
        var url = BASE + "adminpanel/" + module + "/UpdatePublish?tablename=" + tablename + "&fieldname=" + fieldname + "&value=" + value + "&id=" + intglcode + "&othertablename=" + othertable;
    xmlHttp.onreadystatechange = function ()
    {
        if (xmlHttp.readyState == 1)
        {
            SetBackground();
        }
        if ((xmlHttp.readyState == 4 || xmlHttp.readyState == "complete") && (xmlHttp.status == 200))
        {
            var result = xmlHttp.responseText;
            if (result == 1)
            {
                if (value == 'Y')
                {
                    document.getElementById('tick-' + intglcode).src = BASE + 'admin-media/images/tick.png';
                    if (document.getElementById('tick-' + intglcode).title == "UnSubscribed")
                        document.getElementById('tick-' + intglcode).title = 'Subscribed';
                    else
                        document.getElementById('tick-' + intglcode).title = 'Hide me';
                }
                else
                {
                    document.getElementById('tick-' + intglcode).src = BASE + 'admin-media/images/tick_cross.png';
                    if (document.getElementById('tick-' + intglcode).title == "Subscribed")
                        document.getElementById('tick-' + intglcode).title = 'UnSubscribed';
                    else
                        document.getElementById('tick-' + intglcode).title = 'Display me';
                }
            }
            else
            {
                alert("Sorry could not update...");
            }
            UnsetBackground();
        }
    };
    // alert(url);
    xmlHttp.open("GET", url, true);
    xmlHttp.send(null);
}


/*************End **********/

/******************************* SEND GRID BY TRASHMANAGER  *************************************/

function SendGridBindRequestTrashmanager(url, targetdiv, action, chkidfordelete, view, tablename) {


    xmlHttp = GetXmlHttpObject();
    if (xmlHttp != null) {

        xmlHttp.onreadystatechange = function () {
            if (xmlHttp.readyState == 1) {

                SetBackground()
            }

            if ((xmlHttp.readyState == 4 || xmlHttp.readyState == "complete") && (xmlHttp.status == 200)) {
                var str = xmlHttp.responseText;

                document.getElementById(targetdiv).innerHTML = '';

                document.getElementById(targetdiv).innerHTML = str;

                UnsetBackground();

                switch (action) {
                    case 'R': // to set the focus on the search text field
                        alert('The record(s) has been successfully restored.');
                        break;
                    case 'D': // to set the focus on the go to page text field on top
                        alert('The record(s) has been successfully deleted.');
                        break;
                    case"DA":
                        alert("The record(s) has been successfully deleted.");
                        break
                }
            }
        };

        var appendurl = '';

        switch (action) {
            case 'D': // This is for delete

                var chkelements = document.getElementsByName(chkidfordelete);
                var ids = "";
                var countChecked = 0;
                for (var i = 0; i < chkelements.length; i++) {
                    if (chkelements.item(i).checked == true) {
                        countChecked++;
                        if (ids != "")
                            ids += ",";
                        ids += chkelements.item(i).value;
                    }
                }
                if (countChecked == 0) {
                    alert("Please select atleast one record for delete.");
                    return false;
                }
                if (!confirm('Caution! The selected records will be deleted. Press OK to confirm.')) {
                    return false;
                }

                var totalpagerecords = document.getElementById('ptrecords').value;
//                var pid = document.getElementById('pid').value;
                appendurl = '/delete?ptotalr=' + totalpagerecords + '&dids=' + ids + '&view=' + view + '&tablename=' + tablename;

                break;
            case"DA":

                if (!confirm(" Are you sure you want to delete All Trash Records? The deleted records will be removed from the database and will not be available later on into the AdminPanel. Click OK to continue.")) {
                    return false
                }
//                appendurl ="/deleteAll?delAll=1";
                var totalpagerecords1 = document.getElementById('ptrecords').value;
                appendurl = '/deleteAll?ptotalr=' + totalpagerecords1 + '&view=' + view + '&tablename=' + tablename;
                break;

            case 'R':

                var chkelements = document.getElementsByName(chkidfordelete);
                var ids = "";
                var countChecked = 0;
                for (var i = 0; i < chkelements.length; i++) {
                    if (chkelements.item(i).checked == true) {
                        countChecked++;
                        if (ids != "")
                            ids += ",";
                        ids += chkelements.item(i).value;
                    }
                }
                if (countChecked == 0) {
                    alert("Please select atleast one record for restore.");
                    return false;
                }
                if (!confirm('This will restore the selected records. Are you sure you want to continue?')) {
                    return false;
                }
                //alert(ids);
                var totalpagerecords = document.getElementById('ptrecords').value;

                appendurl = '/restore?ptotalr=' + totalpagerecords + '&rids=' + ids + "&tablename=" + tablename + "&view=" + view;
                // alert(appendurl);
                break;
        }
        xmlHttp.open('GET', url + appendurl + '&ajax=Y', true);
        xmlHttp.send(null);
    } else {
        alert("Your browser does not support HTTP Request.");
    }
    return true;
}

/****************************** END  ****************************************/


/*********** Ajax Loader New *************/
function ProcessLoader()
{

    //    document.getElementById('dvprocessing').style.display = '';
    document.getElementById('dvprocessing').style.display = '';
}
/****************************************/
function CalculateTop(Height)
{
    var ScrollTop = document.body.scrollTop;
    if (ScrollTop == 0)
    {
        if (window.pageYOffset)
            ScrollTop = window.pageYOffset;
        else
            ScrollTop = (document.body.parentElement) ? document.body.parentElement.scrollTop : 0;
    }

    var BodyHeight = document.body.clientHeight;

    if (BodyHeight == 0)
    {
        BodyHeight = window.innerHeight;
    }
    if (BodyHeight == 0)
    {
        BodyHeight = document.documentElement.clientHeight
    }

    var myWidth = 0, myHeight = 0;
    if (typeof (window.innerWidth) == 'number')
    {
        //Non-IE
        myWidth = window.innerWidth;
        myHeight = window.innerHeight;
    }
    else if (document.documentElement && (document.documentElement.clientWidth || document.documentElement.clientHeight))
    {
        //IE 6+ in 'standards compliant mode'
        myWidth = document.documentElement.clientWidth;
        myHeight = document.documentElement.clientHeight;
    }
    else if (document.body && (document.body.clientWidth || document.body.clientHeight))
    {
        //IE 4 compatible
        myWidth = document.body.clientWidth;
        myHeight = document.body.clientHeight;
    }
    var FinalTop = ((myHeight - Height) / 2) + ScrollTop;
    return FinalTop;
}

function CalculateLeft(Weight)
{
    var ScrollLeft = document.body.scrollLeft;

    if (ScrollLeft == 0)
    {
        if (window.pageXOffset)
            ScrollLeft = window.pageXOffset;
        else
            ScrollLeft = (document.body.parentElement) ? document.body.parentElement.scrollLeft : 0;
    }

    var BodyWeight = document.documentElement.clientWidth;

    if (BodyWeight == 0)
    {
        BodyWeight = document.body.clientWidth;
    }

    var FinalLeft = (BodyWeight + ScrollLeft - Weight) / 2;

    return FinalLeft;
}

/***************** Setting the Dimmer while loading *********************/

function hideIframe()
{
    if (ie)
    {
        var theIframe = document.getElementById("fadeboxiframe")

        if (theIframe != null)
        {
            theIframe.style.display = "none";
        }
    }
}

function SetBackground()
{

    document.getElementById('dvprocessing').style.display = '';
}
function UnsetBackground()
{

    document.getElementById('dimmer').style.width = 110;
    document.getElementById('dimmer').style.height = 0;
    document.getElementById('dimmer').style.visibility = "";
    document.getElementById('dvprocessing').style.display = 'none';
}





function unhideIframe()
{
    if (ie)
    {
        var theIframe = document.getElementById("fadeboxiframe")
        var theDiv = document.getElementById("dvregisterfrm");
        theIframe.style.width = theDiv.offsetWidth + 'px';
        theIframe.style.height = theDiv.offsetHeight + 'px';
        theIframe.style.top = theDiv.offsetTop + 'px';
        theIframe.style.left = theDiv.offsetLeft + 'px';
        theIframe.style.display = '';
    }
}

/***********************************************************************/

function GetBodyWidth()
{
    var theWidth = 0;
    if (document.body)
    {
        theWidth = document.body.clientWidth;
    }
    else if (document.documentElement && document.documentElement.clientWidth)
    {
        theWidth = document.documentElement.clientWidth;
    }
    else if (window.innerWidth)
    {
        theWidth = window.innerWidth;
    }

    theWidth = theWidth - 80;

    return theWidth + "px";
}

function GetBodyHeight()
{
    var theHeight1 = 0;
    var theHeight2 = 0;
    var theHeight3 = 0;

    if (window.innerHeight)
    {
        theHeight1 = window.innerHeight;
    }

    if (document.documentElement && document.documentElement.clientHeight)
    {
        theHeight2 = document.documentElement.clientHeight;
    }

    FinalHeight = Math.max(theHeight1, theHeight2, theHeight3);
    FinalHeight = FinalHeight - 70;
    return FinalHeight + "px";

}



function SendGridBindRequest(url, targetdiv, action, chkidfordelete, module, flgdisorder, flagvalue, textstr, textstr1, textstr2, text2, txt4, fk_menu, mod_name)
{



    xmlHttp = GetXmlHttpObject();
    if (xmlHttp != null)
    {
        xmlHttp.onreadystatechange = function ()
        {
            if (xmlHttp.readyState == 1)
            {
                SetBackground();
            }

            if ((xmlHttp.readyState == 4 || xmlHttp.readyState == "complete") && (xmlHttp.status == 200))
            {
                var str = trim(xmlHttp.responseText);
                //                $(document).ready(function(){
                //                    var Total = $("#Totalprice").val();
                //                    $(".TotalPrice").html(Total);
                //                });
                document.getElementById(targetdiv).innerHTML = '';
                document.getElementById(targetdiv).innerHTML = str;


                if ($("#property_map").size()) {
                    init_map();
                }

                if ($("#resvcalendar_div").size()) {

                    correctCalendarListing();
                }

                restricted_access();            // to provide access control


                if (flagvalue != '' && (flagvalue == 'uman' || flagvalue == 'ser'))
                {
                    if (flagvalue == 'uman')
                    {
                        var textareaid = 'main_description';
                        var boxwidth = 'auto';
                        var toolbartype = 'Default';
                    }
                    else
                    {
                        var textareaid = 'var_email_signature';

                        if (CKEDITOR.instances['main_description'])
                        {
                            CKEDITOR.remove(CKEDITOR.instances['main_description']); // with or without this line of code - rise an error }
                        }
                        var boxwidth = '700';
                        var toolbartype = 'OnlyBasic';
                    }

                    var editorInstance;

                    if (CKEDITOR.instances[textareaid])
                    {
                        CKEDITOR.remove(CKEDITOR.instances[textareaid]); // with or without this line of code - rise an error }
                    }

                    editorInstance = CKEDITOR.replace(textareaid, {
                        toolbar: toolbartype,
                        skin: 'kama',
                        width: boxwidth,
                        filebrowserBrowseUrl: '../../ckeditor/pdw_file_browser/index.php?editor=ckeditor',
                        filebrowserImageBrowseUrl: '../../ckeditor/pdw_file_browser/index.php?editor=ckeditor&filter=image',
                        filebrowserFlashBrowseUrl: '../../ckeditor/pdw_file_browser/index.php?editor=ckeditor&filter=flash'
                    });

                    if (flagvalue == 'uman')
                    {
                        if (document.getElementById('chr_maintenance').checked == true)
                        {
                            document.getElementById('ckeditordiv').style.display = '';
                            document.getElementById('ckeditormaindiv').style.display = '';
                        }
                        else
                        {
                            document.getElementById('ckeditordiv').style.display = 'none';
                            document.getElementById('ckeditormaindiv').style.display = 'none';
                        }
                    }
                }

                UnsetBackground();



                switch (action)
                {
                    case 'S': // to set the focus on the search text field
                        document.getElementById('searchtxt1').focus();
                        break;

                    case 'Gtop': // to set the focus on the go to page text field on top
                        document.getElementById('txtgotopagetop').focus();
                        break;

                    case 'Gbottom': // to set the focus on the go to page text field on bottom
                        document.getElementById('txtgotopagebottom').focus();
                        break;

                    case 'D': // This is when the delete button is clicked

//                        alert("Selected record(s) has been deleted Successfully.");
                        break;
                    case"DA":
                        alert("The records have been deleted successfully.");
                        break;

                    case 'PG': // This is when the delete button is clicked

                        alert("Caution! This album(s) assigned for Menucategory so once you deleted, it will be deleted from there also.Press OK to confirm.");
                        break;

                    case 'none': // This is for delete ids directly passed
                        alert("No Records deleted .");
                        break;

                    case 'PS': //This is for for focusing display select box
                        var position = trim(document.getElementById('position').value);
                        document.getElementById('cmbdisplay' + position).focus();
                        break;

                    case 'FT':
                        document.getElementById('filterbytop').focus();
                        break;

                    case 'FB':
                        document.getElementById('filterbybottom').focus();
                        break;
                    case 'FS':
                        document.getElementById('filterbystatus').focus();
                        break;

                    case 'MT':
                        document.getElementById('cmbmodulestop').focus();
                        break;

                    case 'MB':
                        document.getElementById('cmbmodulesbottom').focus();
                        break;
                }
            }
        };

        var appendurl = '';

        // alert(url);

        switch (action)
        {
            case 'gridpagescombo':
                var fk_pages = document.getElementById('fk_pages').value;
                appendurl = '&fk_pages=' + fk_pages;
                break;

            case 'positionCombo':
                var fk_position = document.getElementById('fk_position').value;
                appendurl = '&fk_position=' + fk_position;
                break;

            case 'search_university':

                var university = document.getElementById('fk_university').value;
                appendurl = '&fk_university=' + university;
//                alert(appendurl);
                break;
            case 'search_publishcmb':

                var chr_pub = document.getElementById('chr_publishcmb').value;
                appendurl = '&chr_publishcmb=' + chr_pub;
//                alert(appendurl);
                break;

            case 'search_postcategory':
                var chr_post_category = document.getElementById('fk_postcategory').value;
                appendurl = '&fk_postcategory=' + chr_post_category;
//                alert(appendurl);
                break;

            case 'search_chr_status':
                var chr_statuscmb1 = document.getElementById('chr_statuscmb').value;
                appendurl = '&chr_statuscmb=' + chr_statuscmb1;
                break;

            case 'search_spamcount':
                var chr_spamcount = document.getElementById('chr_spamcount').value;
                appendurl = '&chr_spamcount=' + chr_spamcount;
//                alert(appendurl);
                break;

            case 'search_create_date':

                var Create_date = document.getElementById('create_date').value;
                appendurl = '&create_date=' + Create_date;
                break;


            case 'date_search':
                var var_orderlead = document.getElementById('date_search1').value;
                appendurl = '&searchdate=' + var_orderlead;
                //alert(appendurl);
                break;

            case 'filter_pages':
                var var_name = document.getElementById('filter_pages').value;
                appendurl = '&filter_pages=' + var_name;
                //alert(appendurl);
                break;

            case 'PStop':

                var pagesize = trim(document.getElementById('cmbdisplaytop').value);

                if (url.indexOf("?") > -1) {
                    appendurl = '&pagesize=' + pagesize;
                }
                else {
                    appendurl = '?pagesize=' + pagesize;
                }

                //alert(appendurl)		 ; return false;
                if (chkObjects('cmbmodulestop'))
                {
                    var filterby = trim(document.getElementById('cmbmodulestop').value);
                    appendurl = '?pagesize=' + pagesize + '&view=' + filterby;
                }

                break;

            case 'new_PStop':

                var pagesize = trim(document.getElementById('cmbdisplaytop').value);

                if (url.indexOf("?") > -1) {
                    appendurl = '&pagesize=' + pagesize;
                }
                else {
                    appendurl = '?pagesize=' + pagesize;
                }

                //alert(appendurl)		 ; return false;
                if (chkObjects('cmbmodulestop'))
                {
                    var filterby = trim(document.getElementById('cmbmodulestop').value);
                    appendurl = '?pagesize=' + pagesize + '&view=' + filterby;
                }

                break;

            case 'BS':

                var fk_projectglcode = document.getElementById('fk_projectglcode').value;
                appendurl = '&fk_projectglcode=' + fk_projectglcode;
                break;

            case 'PSbottom':

                var pagesize = trim(document.getElementById('cmbdisplaybottom').value);

                //                appendurl = '&pagesize='+pagesize;

                if (url.indexOf("?") > -1) {
                    appendurl = '&pagesize=' + pagesize;
                }
                else {
                    appendurl = '?pagesize=' + pagesize;
                }

                if (chkObjects('cmbmodulesbottom'))
                {
                    var filterby = trim(document.getElementById('cmbmodulesbottom').value);
                    appendurl = '&pagesize=' + pagesize + '&view=' + filterby;
                }

                break;

            case 'S': // This is for search

                var searchtxt = trim(document.getElementById('searchtxt1').value);
                searchtxt = encodeURIComponent(searchtxt);

                var searchby = trim(document.getElementById('searchby').value);
                appendurl = '&searchby=' + searchby + '&searchtxt=' + searchtxt;

                //var searchby = document.getElementById('searchby').value;
                if (url.indexOf("?") > -1) {
                    appendurl = '&searchby=' + searchby + '&searchtxt=' + searchtxt;
                } else {
                    appendurl = '?ajax=Y&searchby=' + searchby + '&searchtxt=' + searchtxt;
                }
                break;

            case 'FT': // This is for filter

                var filterby = trim(document.getElementById('filterbytop').value);
                appendurl = '&filterby=' + filterby;

                break;

            case 'FB': // This is for filter

                var filterby = trim(document.getElementById('filterbybottom').value);
                appendurl = '&filterby=' + filterby;

                break;
            case 'FS': // This is for filter

                var filterby = trim(document.getElementById('filterbystatus').value);
                appendurl = '&filterbystatus=' + filterby;

                break;

            case 'Ytop':
                var cmbyear = document.getElementById('cmbyear').value;

                appendurl = '&cmbyear=' + cmbyear;
                break;

            case 'Ctop':
                var cmbstatus = document.getElementById('cmbstatus').value;
                appendurl = '&cmbstatus=' + cmbstatus;
                break;

            case 'MVF':

                var modval = document.getElementById('module').value;
                appendurl = '&modval=' + modval;
                break;

            case 'MT': // This is for filter by modules in trash manager

                var filterby = trim(document.getElementById('cmbmodulestop').value);
                var tid = document.getElementById('h_view').value;
                document.getElementById('trname').value = document.getElementById('cmbmodulestop').value;
                var pagesize = trim(document.getElementById('cmbdisplaytop').value);

                $(function ()
                {
                    var view = document.getElementById('cmbmodulestop').value;

                    var flagChange = false;
                    $("#searchby").change(function () {
                        flagChange = true;
                        var changeVal = $("#searchby option:selected").val();

                        $("#searchtxt1").autocomplete({
                            source: "index.php?auto=searchval&module=trashmanager&searchbyVal=" + changeVal + "&view=" + view,
                            term: 'term',
                            minLength: 2,
                            select: function (event, ui) {

                                $('#searchtxt1').val(ui.item.id);
                            }
                        });
                    });
                    if (flagChange == false)
                    {
                        $('#searchtxt1').live('keypress', function () {
                            $(this).autocomplete({
                                source: "index.php?auto=searchval&module=trashmanager&searchbyVal=" + $("#searchby option:selected").val() + "&view=" + view,
                                term: 'term',
                                minLength: 2,
                                select: function (event, ui) {

                                    $('#searchtxt1').val(ui.item.id);
                                }
                            });
                        });
                    }
                });

                appendurl = '&view=' + filterby + '&pagesize=' + pagesize;
                window.top.location = url + appendurl;
                break;

            case "CT":

                var mastertype = $("#cmbalbumtop option:selected").val();

                if (mastertype != undefined)
                    appendurl = appendurl + '&albumcode=' + mastertype;

                else
                    appendurl = appendurl + '&albumcode=0';

                var catrgorycode = $("#cmbalbumtop option:selected").val();
                //                 alert(appendurl);

                if (catrgorycode != 0)
                {
                    appendurl = appendurl + '&catrgorycode=' + catrgorycode;
                    // alert(appendurl);
                }
                else
                {
                    appendurl = appendurl + '&catrgorycode=0';
                }
                break;

            case 'MR': // This is for filter by modules in trash manager
                appendurl = "";


                var modulecode = $("#cmbmodulestop option:selected").val();

                if (modulecode != 0 && modulecode != undefined)
                {
                    appendurl = appendurl + '&modulecode=' + modulecode;
                }

                var moduleglcode = $("#moduleglcode").val();

                if (moduleglcode != "" && moduleglcode != undefined)
                {
                    appendurl = appendurl + '&moduleglcode=' + moduleglcode;
                }

                var formtype = $("#cmbformtypetop option:selected").val();

                if (formtype != 0 && formtype != undefined)
                {
                    appendurl = appendurl + '&formtype=' + formtype;
                }

                var pagesize = trim(document.getElementById('cmbdisplaytop').value);
                appendurl += '&pagesize=' + pagesize;

                break;

            case 'MB': // This is for filter by module

                var filterby = trim(document.getElementById('cmbmodulesbottom').value);
                var pagesize = trim(document.getElementById('cmbdisplaybottom').value);
                appendurl = '&view=' + filterby + '&pagesize=' + pagesize;

                break;

            case 'Gtop': // This is for go to page text field top

                var noofpages = trim(document.getElementById('hdnnoofpages').value);
                var enteredpageno = trim(document.getElementById('txtgotopagetop').value);
                if (enteredpageno == '' || enteredpageno == 0)
                {
                    alert("Please enter page number.");
                    document.getElementById('txtgotopagetop').focus();
                    return false;
                }
                else if (parseInt(enteredpageno) > parseInt(noofpages))
                {
                    alert("Please enter proper page number.");
                    document.getElementById('txtgotopagetop').focus();
                    return false;
                }
                appendurl = '&pagenumber=' + enteredpageno;
                break;

            case 'Gbottom': // This is for go to page text field bottom

                var noofpages_2 = trim(document.getElementById('hdnnoofpages').value);
                var enteredpageno_2 = trim(document.getElementById('txtgotopagebottom').value);
                if (enteredpageno_2 == '' || enteredpageno_2 == 0)
                {
                    alert("Please enter page number.");
                    document.getElementById('txtgotopagebottom').focus();
                    return false;
                }
                else if (parseInt(enteredpageno_2) > parseInt(noofpages_2))
                {
                    alert("Please enter proper page number.");
                    document.getElementById('txtgotopagebottom').focus();
                    return false;
                }
                appendurl = '&pagenumber=' + enteredpageno_2;
                break;

            case 'D': // This is for delete

                /*var chkelements = document.getElementsByName(chkidfordelete);
                 
                 var ids = "";
                 var countChecked = 0;
                 
                 for(var i = 0; i < chkelements.length; i++)
                 {
                 if(chkelements.item(i).checked == true)
                 //   alert(chkelements.length);
                 if(chkelements.item(i).checked == true)
                 // alert(chkelements.length);
                 if(chkelements.item(i).checked == true)
                 {
                 countChecked++;
                 if(ids != "")
                 ids += ",";
                 ids += chkelements.item(i).value;
                 // alert(ids);
                 }
                 }
                 if(countChecked == 0)
                 {
                 // alert(countChecked);
                 alert(" Please select atleast one record to be deleted.");
                 return false;
                 }
                 if(!confirm('Caution! The selected records will be deleted. Press OK to confirm.'))
                 {
                 return false;
                 }
                 
                 var totalpagerecords = document.getElementById('ptrecords').value;
                 if(textstr=='')
                 {
                 alert("yyse");
                 appendurl = '/delete?ptotalr='+totalpagerecords+'&dids='+ids+'&rid='+flgdisorder+'&pid='+flagvalue;
                 
                 }
                 else{
                 alert("no");
                 appendurl = '/delete?ptotalr='+totalpagerecords+'&dids='+ids+'&rid='+flgdisorder+'&pid='+flagvalue+'&fk_dive='+textstr;
                 }
                 // alert(appendurl);
                 break;
                 */

                var chkelements = document.getElementsByName(chkidfordelete);
                if (mod_name == 'photoalbum') {
                    var fk_menu = document.getElementsByName('fk_menu');
                }
                var ids = "";
                if (mod_name == 'photoalbum') {
                    var fkids = "";
                }
                var countChecked = 0;
                for (var i = 0; i < chkelements.length; i++)
                {
                    if (chkelements.item(i).checked == true)
                    {
                        countChecked++;
                        if (ids != "")
                            ids += ",";
                        ids += chkelements.item(i).value;
                        if (mod_name == 'photoalbum') {
                            if (fk_menu.item(i).value == 'M' && fkids == '') {
                                fkids = fk_menu.item(i).value;
                            }
                        }
                    }
                }

                if (countChecked == 0)
                {
                    alert("Please select atleast one record to be deleted.");
                    return false;
                }

                if (fkids == 'M') {
                    if (!confirm('Caution! This album(s) assigned for Menu category so once you deleted, it will be deleted from there also. Press OK to confirm.'))
                    {
                        return false;
                    }
                }
                else {
                    if (!confirm('Caution! The selected records will be deleted. Press OK to confirm.'))
                    {
                        return false;
                    }
                }

                if (flgdisorder != '') {
                    var modval = '&modval=' + flgdisorder;
                } else {
                    var modval = '';
                }

                var totalpagerecords = document.getElementById('ptrecords').value;


                if (module != '') {
//                        alert(module);
                    var pids = document.getElementById('pid').value;
                } else {
                    var pids = "";
                }

//            }else {
//                var pids = "";
//            }
                appendurl = '/delete?ptotalr=' + totalpagerecords + '&dids=' + ids + '&rid=' + flgdisorder + '&pid=' + flagvalue + '&fk_productid=' + textstr + '&fk_category=' + textstr1 + '&pp_type=' + textstr2 + '&fk_category=' + text2 + '&e_id=' + txt4 + '&pid=' + pids;
                //   appendurl = '/delete?ptotalr='+totalpagerecords+'&dids='+ids+'&rid='+flgdisorder+'&pid='+flagvalue+'&fk_dive=';

                //                alert(appendurl);
                break;

            case"DA":

                if (!confirm("Are you sure you want to delete Log Records of all modules?  Click OK to continue")) {
                    return false
                }
                appendurl = "/deleteAll?id=";
                break;
            case 'Delids': // This is for delete ids directly passed

                var ids = chkidfordelete;
                var totalpagerecords = document.getElementById('ptrecords').value;
                appendurl = '&action=delete&ptotalr=' + totalpagerecords + '&dids=' + ids;
                break;

            case 'AP': // This is for approve in grid
                appendurl = '&QT=4';
                break;

            case 'DISP': // This is for display in grid
                appendurl = '&action=display&QT=5';
                break;

            case 'DEFAULT': // This is for display in grid
                appendurl = '&action=setdefault&QT=5';
                break;

            case 'APR': // This is for approve rating in grid
                appendurl = '&QT=7';
                break;

            case 'DO': // This is for bulk display order in grid
                var totalrows = document.getElementById('ptrecords').value;
                var ids = "";
                var values = "";
                var oldvalues = "";
                var commonglcode = "";

                var elementforid = "";
                var elementforvalues = "";
                var elementforoldvalues = "";
                var elementforcommonglcodes = "";

                for (var i = 0; i < totalrows; i++)
                {
                    if (ids != "")
                        ids += ",";

                    if (values != "")
                        values += ",";

                    if (oldvalues != "")
                        oldvalues += ",";

                    elementforid = "hdnintglcode" + i;
                    elementforvalues = "displayorder" + i;
                    elementforoldvalues = "hdndisplayorder" + i;

                    if (document.getElementById(elementforvalues).value == "")
                    {
                        alert("Field(s) cannot be left blank.");
                        document.getElementById(elementforvalues).focus();
                        return;
                    }
                    if (document.getElementById(elementforvalues).value == 0)
                    {
                        alert("Sorry! The Display Order Value cannot be Zero.");
                        document.getElementById(elementforvalues).focus();
                        return;
                    }

                    if (trim(document.getElementById(elementforvalues).value) == "")//change by jshah to stop multiple spaces
                    {
                        alert("Field(s) can not be left blank.");
                        document.getElementById(elementforvalues).focus();
                        return;
                    }

                    ids += document.getElementById(elementforid).value;
                    values += document.getElementById(elementforvalues).value;
                    oldvalues += document.getElementById(elementforoldvalues).value;

                    if (flgdisorder)
                    {
                        if (commonglcode != "")
                            commonglcode += ",";
                        elementforcommonglcodes = "hdncommonglcode" + i;
                        commonglcode += document.getElementById(elementforcommonglcodes).value;
                    }
                }
                url += "/orderupdate?";

                //url = url.replace("/?","/orderupdate?");

                appendurl = 'uids=' + ids + '&uvals=' + values + '&uoldvals=' + oldvalues + '&cmnglcode=' + commonglcode;
                //alert(appendurl);
                break;


            case 'R': // This is for bulk rating order in grid

                var totalrows = document.getElementById('ptrecords').value;
                var ids = "";
                var values = "";
                var oldvalues = "";
                var commonglcode = "";

                var elementforid = "";
                var elementforvalues = "";
                var elementforoldvalues = "";
                var elementforcommonglcodes = "";

                for (var i = 0; i < totalrows; i++) {

                    if (ids != "")
                        ids += ",";

                    if (values != "")
                        values += ",";

                    if (oldvalues != "")
                        oldvalues += ",";

                    elementforid = "hdnintglcode" + i;
                    elementforvalues = "displayorder" + i;
                    elementforoldvalues = "hdndisplayorder" + i;

                    if (trim(document.getElementById(elementforvalues).value) == "") {
                        alert("Field(s) cannot be left blank.");
                        document.getElementById(elementforvalues).focus();
                        return false;
                    }
                    //alert(document.getElementById(elementforvalues).value);
                    if (trim(document.getElementById(elementforvalues).value) <= 0) {

                        alert("Display rank cannot be less than 10.");
                        document.getElementById(elementforvalues).focus();
                        return false;
                    }
                    if (document.getElementById(elementforvalues).value > 99) {

                        alert("Display rank must not be greater than 99.");
                        document.getElementById(elementforvalues).focus();
                        return false;
                    }

                    ids += document.getElementById(elementforid).value;
                    values += document.getElementById(elementforvalues).value;
                    oldvalues += document.getElementById(elementforoldvalues).value;

                    if (flgdisorder) {
                        if (commonglcode != "")
                            commonglcode += ",";

                        elementforcommonglcodes = "hdncommonglcode" + i;
                        commonglcode += document.getElementById(elementforcommonglcodes).value;
                    }
                }
                url += "/orderupdate?";
                appendurl = '&task=orderupdate&uids=' + ids + '&uvals=' + values + '&uoldvals=' + oldvalues + '&cmnglcode=' + commonglcode;
                break;

            case 'vendorcmb':
                var status = document.getElementById('fk_status').value;
                var vendor = document.getElementById('fk_vendor').value;
                var certi_category = document.getElementById('fk_certi_category').value;
                appendurl = '&vendor=' + vendor + '&status=' + status + '&certi_category=' + certi_category;
                break;

            case 'certi_categorycmb':

                var status = document.getElementById('fk_status').value;
                var vendor = document.getElementById('fk_vendor').value;
                var certi_category = document.getElementById('fk_certi_category').value;
                appendurl = '&vendor=' + vendor + '&status=' + status + '&certi_category=' + certi_category;
                break;


            case 'StatusCmb':

                var vendor = document.getElementById('fk_vendor').value;
                var status = document.getElementById('fk_status').value;
                var certi_category = document.getElementById('fk_certi_category').value;
                appendurl = '&status=' + status + '&vendor=' + vendor + '&certi_category=' + certi_category;

                break;


                ///////////   USED IN 2nd Home  ////////////////////////////////////////////////////////////////////////////


            case 'SRES':

                var dt_from_date = $("#dt_from_date").val();
                var dt_to_date = $("#dt_to_date").val();
                var dt_from_amount = $("#dt_from_amount").val();
                var dt_to_amount = $("#dt_to_amount").val();
                var reseravationfilter = $("#Filterbyreservation").val();
                var resv_year = '';

                if (reseravationfilter == 'Y') {
                    resv_year = $("#resv_year").val();
                }

                appendurl = '&dt_from_date=' + dt_from_date + '&dt_to_date=' + dt_to_date + '&dt_from_amount=' + dt_from_amount + '&dt_to_amount=' + dt_to_amount + '&reseravationfilter=' + reseravationfilter + '&resv_year=' + resv_year;

                break;


                /////////////////////////START BATCH REPORT ////////////////////////     

            case 'BETCH':
                var var_customer = $("#var_customer").val();
                var var_approveno = $("#var_approveno").val();
                var dt_from_date = $("#dt_from_date").val();
                var dt_to_date = $("#dt_to_date").val();
                var dt_from_pay = $("#dt_from_pay").val();
                var dt_to_pay = $("#dt_to_pay").val();
                var batchnoreseravation = $("#batchnoreseravation").val();

                appendurl = '&var_customer=' + var_customer + '&var_approveno=' + var_approveno + '&dt_from_pay=' + dt_from_pay + '&dt_to_pay=' + dt_to_pay + '&dt_to_date=' + dt_to_date + '&dt_from_date=' + dt_from_date + '&batchnoreseravation=' + batchnoreseravation;

                break;


            case 'BETCHNO':

                var batch_number = $("#batch_number").val();

                appendurl = '&batch_number=' + batch_number;

                break;

                /////////////////////////END BATCH REPORT ////////////////////////     

                /////////////////////////START REVENUE REPORT ////////////////////

            case 'REVENUE_FILTER':

                var dt_from_date = '';
                var dt_to_date = '';
                var year_val = '';

                var yearDateFilterCombo = $("#yearDateFilterCombo").val();

                if (yearDateFilterCombo == 'D') {
                    dt_from_date = $("#dt_from_date").val();
                    dt_to_date = $("#dt_to_date").val();
                }
                else {
                    year_val = $("#year").val();
                }


                var fk_users = $("#fk_users").val();
                var fk_property = $("#fk_property").val();

                appendurl = '&dt_from_date=' + dt_from_date + '&dt_to_date=' + dt_to_date + '&yearDateFilter=' + yearDateFilterCombo + '&year=' + year_val + '&fk_users=' + fk_users + '&fk_property=' + fk_property;
                break;


                /////////////////////////END REVENUE REPORT ////////////////////////  

                /////////////////////////START TAX RETURN REPORT ////////////////////////       

            case 'TAX':

                var dt_from_date = '';
                var dt_to_date = '';
                var year_val = '';

                var yearDateFilterCombo = $("#yearDateFilterCombo").val();

                if (yearDateFilterCombo == 'D') {
                    dt_from_date = $("#dt_from_date").val();
                    dt_to_date = $("#dt_to_date").val();
                }
                else {
                    year_val = $("#year").val();
                }

                var fk_users = $("#fk_users").val();
                var fk_property = $("#fk_property").val();

                appendurl = '&dt_from_date=' + dt_from_date + '&dt_to_date=' + dt_to_date + '&yearDateFilter=' + yearDateFilterCombo + '&year=' + year_val + '&fk_users=' + fk_users + '&fk_property=' + fk_property;
                break;




                ///////////////////////// END TAX RETURN REPORT ////////////////////////                    

                ///////////////////////// START RATE REPORT ////////////////////////             

            case 'RATE':

                var dt_from_date = '';
                var dt_to_date = '';
                var year_val = '';

                var yearDateFilterCombo = $("#yearDateFilterCombo").val();

                if (yearDateFilterCombo == 'D') {
                    dt_from_date = $("#dt_from_date").val();
                    dt_to_date = $("#dt_to_date").val();
                }
                else {
                    year_val = $("#year").val();
                }


                var fk_users = $("#fk_users").val();
                var fk_property = $("#fk_property").val();

                appendurl = '&dt_from_date=' + dt_from_date + '&dt_to_date=' + dt_to_date + '&yearDateFilter=' + yearDateFilterCombo + '&year=' + year_val + '&fk_users=' + fk_users + '&fk_property=' + fk_property;
                break;


                ///////////////////////// END RATE REPORT ////////////////////////            


                ///////////////////////// START BOOKING WINDOW REPORT ////////////////////////             

            case 'BOOKING_WINDOW':

                var dt_from_date = '';
                var dt_to_date = '';
                var year_val = '';

                var yearDateFilterCombo = $("#yearDateFilterCombo").val();

                if (yearDateFilterCombo == 'D') {
                    dt_from_date = $("#dt_from_date").val();
                    dt_to_date = $("#dt_to_date").val();
                }
                else {
                    year_val = $("#year").val();
                }

                var fk_users = $("#fk_users").val();
                var fk_property = $("#fk_property").val();

                appendurl = '&dt_from_date=' + dt_from_date + '&dt_to_date=' + dt_to_date + '&yearDateFilter=' + yearDateFilterCombo + '&year=' + year_val + '&fk_users=' + fk_users + '&fk_property=' + fk_property;
                break;


                ///////////////////////// END BOOKING WINDOW REPORT ////////////////////////  


                ///////////////////////// START ADMIN OCCUPANCY REPORT ////////////////////////             

            case 'ADM':
                var dt_from_date = '';
                var dt_to_date = '';
                var year_val = '';

                var yearDateFilterCombo = $("#yearDateFilterCombo").val();

                if (yearDateFilterCombo == 'D') {
                    dt_from_date = $("#dt_from_date").val();
                    dt_to_date = $("#dt_to_date").val();
                }
                else {
                    year_val = $("#year").val();
                }

                appendurl = '&dt_from_date=' + dt_from_date + '&dt_to_date=' + dt_to_date + '&yearDateFilter=' + yearDateFilterCombo + '&year=' + year_val;
                break;


                ///////////////////////// END ADMIN OCCUPANCY REPORT ////////////////////////            

            case 'PROP_SEARCH_PANEL':

                var fk_property_location = $("#fk_property_location").val();
                var fk_property_category = $("#fk_property_category").val();

                appendurl = '&fk_property_location=' + fk_property_location + '&fk_property_category=' + fk_property_category;
                break;


        }

        url = encodeURI(url + appendurl + '&ajax=Y');
        if (url != '')
        {
            url = url.replace(/#/g, "");
        }
        xmlHttp.open('GET', url, false);
        //        xmlHttp.open('GET', url + '&ajax=Y' + appendurl, true);
        //        xmlHttp.open('GET', urlArray[0] +"?"+ appendurl + '&ajax=Y', true);
        xmlHttp.send(null);
    }
    else
    {
        alert("Your browser does not support HTTP Request");
    }
    return true;
}


// Common function for updating a star
function UpdateStar(mediaurl, baseurl, tablename, fieldname, intglcode)
{

    xmlHttp = GetXmlHttpObject();
    if (xmlHttp == null)
    {
        alert("Your browser does not support XMLHTTP!");
        return;
    }

    var path = document.getElementById('star-' + intglcode).src;
    var file_a = path.substring(path.lastIndexOf("/") + 1, path.length);
    var value;
    if (file_a == 'gstar.png')
    {
        value = 'N';
    }
    else if (file_a == 'gstar-disable.png')
    {
        value = 'Y';
    }

    var url = baseurl + "adminpanel/dashboard?ajax=Y&tablename=" + tablename + "&fieldname=" + fieldname + "&value=" + value + "&id=" + intglcode;
    //    alert(url);
    //var url = "commanajax.php?method=updatefield&tablename="+tablename+"&fieldname="+fieldname+"&value="+value+"&id="+intglcode;
    xmlHttp.onreadystatechange = function ()
    {
        if (xmlHttp.readyState == 1)
        {
            //ProcessLoader();
            SetBackground();
        }
        if ((xmlHttp.readyState == 4 || xmlHttp.readyState == "complete") && (xmlHttp.status == 200))
        {
            var result = xmlHttp.responseText;

            if (result == 1)
            {
                if (value == 'Y')
                {
                    document.getElementById('star-' + intglcode).src = mediaurl + '/images/gstar.png';
                    document.getElementById('star-' + intglcode).title = 'Star';
                    //                    
                    //  document.getElementById('star-'+intglcode).onclick = function(){UpdateStar('pst_restaurant','chrstar','N',intglcode);};
                }
                else
                {
                    document.getElementById('star-' + intglcode).src = mediaurl + '/images/gstar-disable.png';
                    document.getElementById('star-' + intglcode).title = 'Unstar';
                    // document.getElementById('star-'+intglcode).onclick = function(){UpdateStar('pst_restaurant','chrstar','Y',intglcode);};

                }
            }
            else
            {
                alert("Sorry could not update...");
            }
            //			
            UnsetBackground();

        }
    };

    xmlHttp.open("GET", url, true);
    xmlHttp.send(null);
}

// End Of Common function for updating star

function updatereadstar(modulename, action, cmbid, tablename, chkidfordelete)
{

    if (document.getElementById(cmbid).value == '0')
        return false;
    xmlHttp = GetXmlHttpObject();
    if (xmlHttp == null)
    {
        alert("Your browser does not support XMLHTTP!");
        return;
    }
    var chkelements = document.getElementsByName(chkidfordelete);

    var ids = "";
    var countChecked = 0;

    for (var i = 0; i < chkelements.length; i++)
    {

        if (chkelements.item(i).checked == true)
        {
            countChecked++;
            if (ids != "")
                ids += ",";
            ids += chkelements.item(i).value;
        }
    }


    if (countChecked == 0)
    {
        alert(" Please select atleast one record to be changed.");
        document.getElementById('cmbmoreactiontop').value = '0';
        return false;
    }

    var cmboption = document.getElementById(cmbid).value;
    var fieldname;
    var value;
    switch (cmboption)
    {
        case 'r': // To Mark As Read
            fieldname = 'chr_read';
            value = 'Y';
            break;
        case 'ur': // To Mark As UnRead
            fieldname = 'chr_read';
            value = 'N';
            break;
        case 'as': // Too Add Star
            fieldname = 'chr_star';
            value = 'Y';
            break;
        case 'rs': // Too Remove Star
            fieldname = 'chr_star';
            value = 'N';
            break;

    }
    var url = modulename;

    //     var url = "index.php?ajax=Y&tablename="+tablename+"&fieldname="+fieldname+"&value="+value+"&id="+ids+"&module="+modulename;
    //    alert(url);

    SetBackground();
    $.ajax({
        type: "GET",
        url: "pages/" + action,
        data: "ajax=Y&tablename=" + tablename + "&fieldname=" + fieldname + "&value=" + value + "&id=" + ids,
        async: false,
        success: function (result) {

            //  var result = xmlHttp.responseText;

            var idarray = ids.split(',');
            var classname;
            var classarray;
            var finalclassname;

            if (result == 1)
            {
                if (value == 'Y' && fieldname == 'chr_star')
                {
                    for (var i = 0, len = idarray.length; i < len; ++i) {

                        document.getElementById('star-' + idarray[i]).src = 'html/images/gstar.png';
                        document.getElementById('star-' + idarray[i]).title = 'Starred';
                    }
                }
                else if (value == 'N' && fieldname == 'chr_star')
                {
                    for (var i = 0, len = idarray.length; i < len; ++i) {

                        document.getElementById('star-' + idarray[i]).src = 'html/images/gstar-disable.png';
                        document.getElementById('star-' + idarray[i]).title = 'Not starred';
                    }
                }


                if (value == 'Y' && fieldname == 'chr_read')
                {
                    for (var i = 0, len = idarray.length; i < len; ++i)
                    {


                        //document.getElementById('gtr-'+idarray[i]).className = 'grid-list-inner-table-text';
                        $("#gtr-" + idarray[i]).addClass('grid-list-inner-table-text');
                        if (document.getElementById('imgStar-' + idarray[i]))
                        {

                            $("#star1-" + idarray[i]).hide();

                        }

                    }
                }
                if (value == 'N' && fieldname == 'chr_read')
                {

                    for (var i = 0, len = idarray.length; i < len; ++i)
                    {


                        $("#gtr-" + idarray[i]).addClass('grid-list-inner-table-text-active');

                        $("#star1-" + idarray[i]).show();



                    }
                }

                document.getElementById(cmbid).value = '0';
            } else {
                alert("Sorry could not update...");
            }

            UnsetBackground();
        }
    });

    xmlHttp.open("GET", url, true);
    xmlHttp.send(null);
}

//function expandcollapsepanel(panelid)
//{
//
//    if(document.getElementById(panelid).style.display == '')
//    {
//        document.getElementById(panelid).style.display = 'none';
//    }
//    else
//    {
//        document.getElementById(panelid).style.display = '';
//    }
//
//}

function expandcollapsepanel(panelid)
{
    if (document.getElementById(panelid).style.display == '')
    {
        document.getElementById(panelid).style.display = 'none';
    }
    else if (document.getElementById(panelid).style.display == 'block')
    {
        document.getElementById(panelid).style.display = 'none';
    }
    else
    {
        document.getElementById(panelid).style.display = '';
    }
}

function KeycheckOnlyNumeric(e)
{

    var _dom = 0;
    _dom = document.all ? 3 : (document.getElementById ? 1 : (document.layers ? 2 : 0));
    if (document.all)
        e = window.event; // for IE
    var ch = '';
    var KeyID = '';
    if (_dom == 2) {                     // for NN4
        if (e.which > 0)
            ch = '(' + String.fromCharCode(e.which) + ')';
        KeyID = e.which;
    }
    else
    {
        if (_dom == 3) {                   // for IE
            KeyID = (window.event) ? event.keyCode : e.which;
        }
        else {                       // for Mozilla
            if (e.charCode > 0)
                ch = '(' + String.fromCharCode(e.charCode) + ')';
            KeyID = e.charCode;
        }
    }
    /* if((KeyID >= 65 && KeyID <= 90) || (KeyID >= 97 && KeyID <= 122) || (KeyID >= 33 && KeyID <= 47) || (KeyID >= 58 && KeyID <= 64) || (KeyID >= 91 && KeyID <= 96) || (KeyID >= 123 && KeyID <= 126))*/

    if ((KeyID >= 65 && KeyID <= 90) || (KeyID >= 97 && KeyID <= 122) || (KeyID >= 33 && KeyID <= 39) || (KeyID >= 58 && KeyID <= 64) || (KeyID >= 91 && KeyID <= 96) || (KeyID >= 123 && KeyID <= 126) || (KeyID >= 42 && KeyID <= 42) || (KeyID >= 44 && KeyID <= 44) || (KeyID >= 46 && KeyID <= 47))//changed by jshah for stopping spaces
    {
        return false;
    }
    return true;
}

/******** Only Numeric **********/
function KeycheckOnlyPhonenumber(e)
{
    var _dom = 0;
    _dom = document.all ? 3 : (document.getElementById ? 1 : (document.layers ? 2 : 0));
    if (document.all)
        e = window.event; // for IE
    var ch = '';
    var KeyID = '';
    if (_dom == 2) { // for NN4
        if (e.which > 0)
            ch = '(' + String.fromCharCode(e.which) + ')';
        KeyID = e.which;
    }
    else
    {
        if (_dom == 3) { // for IE
            KeyID = (window.event) ? event.keyCode : e.which;
        }
        else { // for Mozilla
            if (e.charCode > 0)
                ch = '(' + String.fromCharCode(e.charCode) + ')';
            KeyID = e.charCode;
        }
    }
    if ((KeyID >= 65 && KeyID <= 90) || (KeyID >= 97 && KeyID <= 122) || (KeyID >= 33 && KeyID <= 39) || (KeyID >= 42 && KeyID <= 42) || (KeyID >= 44 && KeyID <= 47) || (KeyID >= 58 && KeyID <= 64) || (KeyID >= 91 && KeyID <= 96) || (KeyID >= 123 && KeyID <= 126))
    {
        return false;
    }
    return true;
}



function ispercentage(obj, e, allowDecimal, allowNegative)
{
    var key;
    var isCtrl = false;
    var keychar;
    var reg;
    if (window.event)
    {
        key = e.keyCode;
        isCtrl = window.event.ctrlKey
    }
    else if (e.which)
    {
        key = e.which;
        isCtrl = e.ctrlKey;
    }
    if (isNaN(key))
        return true;
    keychar = String.fromCharCode(key);
    // check for backspace or delete, or if Ctrl was pressed
    if (key == 8 || isCtrl)
    {
        return true;
    }
    ctemp = obj.value;
    var index = ctemp.indexOf(".");
    var length = ctemp.length;
    ctemp = ctemp.substring(index, length);

    if (index < 0 && length > 1 && keychar != '.' && keychar != '0')
    {
        obj.focus();
        return false;
    }

    if (length > 1 && ctemp > 10 && keychar != '.')
    {
        obj.focus();
        return false;
    }

    if (ctemp.length > 2)
    {
        obj.focus();
        return false;
    }

    if (keychar == '0' && length >= 2 && keychar != '.' && ctemp != '10') {
        obj.focus();
        return true;
    }
    reg = /\d/;
    var isFirstN = allowNegative ? keychar == '-' && obj.value.indexOf('-') == -1 : false;
    var isFirstD = allowDecimal ? keychar == '.' && obj.value.indexOf('.') == -1 : false;
    return isFirstN || isFirstD || reg.test(keychar);
}

function KeycheckWithDecimal(e)
{
    var _dom = 0;
    _dom = document.all ? 3 : (document.getElementById ? 1 : (document.layers ? 2 : 0));
    if (document.all)
        e = window.event; // for IE
    var ch = '';
    var KeyID = '';
    if (_dom == 2) {                     // for NN4
        if (e.which > 0)
            ch = '(' + String.fromCharCode(e.which) + ')';
        KeyID = e.which;
    }
    else
    {
        if (_dom == 3) {                   // for IE
            KeyID = (window.event) ? event.keyCode : e.which;
        }
        else {                       // for Mozilla
            if (e.charCode > 0)
                ch = '(' + String.fromCharCode(e.charCode) + ')';
            KeyID = e.charCode;
        }
    }
    if (KeyID == 46)
    {
        return true;
    }
    if ((KeyID >= 65 && KeyID <= 90) || (KeyID >= 97 && KeyID <= 122) || (KeyID >= 32 && KeyID <= 47) || (KeyID >= 58 && KeyID <= 64) || (KeyID >= 91 && KeyID <= 96) || (KeyID >= 123 && KeyID <= 126))
    {
        return false;
    }
    return true;
}


function checkemail(str)
{

    var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    return re.test(str);
}

function checkall(id)
{
    if (document.getElementById('chkall').checked == true)
    {
        var chkelements = document.getElementsByName(id);

        for (var i = 0; i < chkelements.length; i++)
        {
            chkelements.item(i).checked = true;
        }
    }
    else
    {
        var chkelements = document.getElementsByName(id);

        for (var i = 0; i < chkelements.length; i++)
        {
            chkelements.item(i).checked = false;
        }
    }
}

function onkeydown_search(evt, searchurl)
{
    //    alert('IN');//function for search box

    var key = (evt.which) ? evt.which : event.keyCode

    if (key == 13)
    {
        SendGridBindRequest(searchurl, 'gridbody', 'S');
        document.getElementById('search').focus();
    }
}

function trim(str, chars) {
    return ltrim(rtrim(str, chars), chars);
}
function ltrim(str, chars) {
    chars = chars || "\\s";
    return str.replace(new RegExp("^[" + chars + "]+", "g"), "");
}
function rtrim(str, chars) {
    chars = chars || "\\s";
    return str.replace(new RegExp("[" + chars + "]+$", "g"), "");
}

function showDiv(e, id1) {

    $('#' + id1).show();
}
function hidediv(id2) {

    $('#' + id2).hide();
}

function chkObjects(theVal)
{
    if (document.getElementById(theVal) != null)
    {
        return true;
    }
    else
    {
        return false;
    }
}

function makeLowercase(var_title, var_alias)
{

    if (typeof var_title == "undefined")
    {
        var_title = "var_title";
    }
    if (typeof var_alias == "undefined")
    {
        var_alias = "var_alias";
    }
    var str = "";
    //  alert(var_title);
    if ($("#" + var_alias).val().length == 0)
        str = document.getElementById(var_title).value.toLowerCase();

    else
        str = $("#" + var_alias).val()
    str = str.toLowerCase();
    // alert(str);
    var temp = new String(str);
    temp = temp.replace(/[^a-z A-Z 0-9 \-]+/g, '');
    temp = trim(temp);

    var strlength = temp.length;
    for (i = 0; i < strlength; i++)
    {
        var alias = temp.split(' ').join('-');
        //  alert(alias);
        //var alias = str.replace(" ", "-");
    }

    document.getElementById(var_alias).value = alias;
}

function removeHTMLTags(value)
{
    var strInputCode = value;
    var str = '';

    str = strInputCode.replace(/&(lt|gt);/g, function (strMatch, p1) {
        return (p1 == "lt") ? "<" : ">";
    });

    str = str.replace(/<\/?[^>]+(>|$)/g, "");
    str = str.replace(/&quot;/g, "");
    str = str.replace(/&#39;/g, "");
    str = str.replace(/&nbsp;/g, " ");
    str = str.replace(/\n/g, " ");

    return str;
}
//===========================before=============================
function checkingAlias(Alias, table, eid, mode, module)
{
    //    alert(Alias+table+eid+mode+module);

    var iChars = "!@#$%^&*()+=[]\\\';,./{}|\":<>?''";

    var alias = document.getElementById(Alias).value;

    if (alias == '')
    {
        $("#aliasmsg").removeClass("alias-valid").addClass("alias-notvalid");
        //alert('Please enter the alias.');
        $("#" + Alias).focus();
        return false;
    }
    else if (document.getElementById("var_alias").value.length < 2) {
        $("#aliasmsg").removeClass("alias-valid").addClass("alias-notvalid");
        //alert('Please enter the alias.');
        $("#" + Alias).focus();
        return false;
    } else {

        for (var i = 0; i < document.getElementById("var_alias").value.length; i++) {
            if (iChars.indexOf(document.getElementById("var_alias").value.charAt(i)) != -1)
            {
                //alert('in');
                $("#aliasmsg").removeClass("alias-valid").addClass("alias-notvalid");
                alert("Alias is not valid.");
                document.getElementById('var_alias').focus();
                return false;
            }
        }
        if (trim(checkSameAlias(alias, table, eid, mode, module)) == 0)
        {
            //$("#aliasmsg").removeClass("alias-valid");
            $("#aliasmsg").removeClass("alias-valid").addClass("alias-notvalid");
            $('#var_alias').addClass("error");
            //            $('').insertAfter('#var_alias');
            //            $('<label for="var_title" id="aliasnote" class="error">Alias already exists. Please change the alias.</label>').insertAfter('#var_alias');
            //            $('<label for="var_title" id="aliasnote" class="error">Alias already exists. Please change the alias.</label>').insertAfter('#var_alias');
            $('#aliasnote').html('');
            // $('<label for="var_alias" id="aliasnote" class="error">Alias already exists. Please change the alias.</label>').insertAfter('#var_alias');
            $('#aliasnote').html('Alias already exists. Please change the alias.');
            //alert('Alias already exists. Please change the alias.');

            $("#" + Alias).focus();
            return false;
        }
        else
        {
            $("#aliasmsg").removeClass("alias-notvalid").addClass('alias-valid');
            return true;
        }
    }
}


function checkSameAlias(alias, table, eid, mode, module)
{
    var msg = $.ajax({
        type: "GET",
        url: BASE + "adminpanel/" + module + "/issameAlias",
        async: false,
        data: "alias=" + encodeURIComponent(alias) + "&table=" + table + "&eid=" + eid + "&mode=" + mode
    }).responseText;

    return msg;

}

function autoalias(a) {

    return $.ajax({
        type: "GET",
        url: BASE + "/adminpanel/dashboard/autoalias",
        async: false,
        data: "alias=" + a
    }).responseText
}
////=================================================================
//
//function checkingAlias1(Alias,table,eid,mode,module)
//{
//
//    //alert(Alias+table+eid+mode+module);
//    
//
//    var iChars = "!@#$%^&*()+=[]\\\';,./{}|\":<>?''";
//
//    var alias = document.getElementById(Alias).value;
//
//    if(alias=='')
//    {
//        $("#aliasmsg").removeClass("alias-valid");
//        //alert('Please enter the alias.');
//        $("#"+Alias).focus();
//        return false;
//    }
//    else
//    {
//        for (var i = 0; i < document.getElementById("var_alias").value.length; i++) {
//            if (iChars.indexOf(document.getElementById("var_alias").value.charAt(i)) != -1)
//            {
//                //alert('in');
//                $("#aliasmsg").removeClass("alias-valid");
//                alert ("Alias is not valid.");
//                document.getElementById('var_alias').focus();
//                return false;
//            }
//        }
//        if(trim(checkSameAlias1(alias,table,eid,mode,module))==0)
//        {
//
//                var str = alias;
//                var n = str.search("-2"); 
//                
//               if(n>0)
//                {
//                    var str = alias;
//                    var alias = str.replace("-2","-3");
//                     var res = document.getElementById('var_alias').value=alias;
//                     
//                }
//                else {
//                var res = document.getElementById('var_alias').value=alias+"-"+"2";
//                }
//                var T =  substr(strrchr(res, '-'), 1);
//                
//                for(i=T;i<10;i++)
//                {
//                    
//                    document.getElementById('var_alias').value=alias+" "+"-"+i;
//                }
////            for(t)
//            
//            
////            $("#"+Alias).focus();
////            return false;
//        }
//        else
//        {
//            makeLowercase1();
////            $("#aliasmsg").addClass("alias-valid");
////            return true;
//        }
//    }
//}
//
////function auto_alias(){
////
////        if(trim(document.getElementById('var_title').value) != '' && trim(document.getElementById('var_alias').value) == '')
////        {
////            
////            document.getElementById('spanabc').style="display:''";
////             if(checkingAlias('var_title','<?= base64_encode("fa_recentdesigns") ?>','<?= base64_encode($eid) ?>','<?= base64_encode('int_glcode') ?>','pages')=='0')
////              {
//////                  alert('var_title');
//////                   document.getElementById('var_alias').value=alias+" "+"-"+"1";
////              }
////              else{
////                   makeLowercase1();
////              }
////        }
////    }
//    
//    function makeLowercase1()
//    {
//        var str= trim(document.getElementById('var_title').value).toLowerCase();
//        
//        
//        
//        var temp = new String(str);
//        temp =  temp.replace(/[^a-z A-Z 0-9 \-]+/g,'');
//        var strlength = temp.length;
//        for(i=0; i < strlength; i++)
//        {
//            var alias=temp.split(' ').join('-');
//        }
//        
//                 
//        document.getElementById('var_alias').value = alias;
//        document.getElementById('spanabc').style="display:''";
//    }
//function checkSameAlias1(alias,table,eid,mode,module)
//{
//    
//    var msg = $.ajax({
//        type: "GET",


//        async: false,
//        data: "alias="+encodeURIComponent(alias)+"&table="+table+"&eid="+eid+"&mode="+mode
//    }).responseText;
//
//    return msg;
//    
//}
//
//function autoalias1(a) {
//    
//    return $.ajax({
//            type: "GET",
//            url: BASE + "/adminpanel/dashboard/autoalias",
//            async: false,
//            data: "alias=" + a
//        }).responseText
//}
// change by ashish

// function parameters are: field - the string field, count - the field for remaining characters number and max - the maximum number of characters
function CountLeft(field, count, max)
{
    // if the length of the string in the input field is greater than the max value, trim it

    if (field.value.length > max)
        field.value = field.value.substring(0, max);
    else
        // calculate the remaining characters
        count.value = max - field.value.length;
}

function checkPasswod(passwordVariable) {

    var myString = document.getElementById(passwordVariable).value;
    var digitString = myString.replace(/[^0-9]/g, "");
    //var specialString = myString.replace(/[a-zA-Z0-9]/g, "");
    var charString = myString.replace(/[^a-zA-Z]/g, "");

    if (trim(document.getElementById(passwordVariable).value) != '') {

        if (trim(document.getElementById(passwordVariable).value).length < 6) {
            alert("Please enter more than 6 characters password.");
            document.getElementById(passwordVariable).focus();
            return false;
        }

        //        if(specialString < 1){
        //            alert("Password must include at least one special (#,@,&,$ etc) character.");
        //            document.getElementById(passwordVariable).focus();
        //            return false;                 
        //				 
        //        }
        if (digitString < 1) {
            alert("Password must include at least one numeric character.");
            document.getElementById(passwordVariable).focus();
            return false;
        }
        if (charString < 1) {
            alert("Password must include at least one alphabate.");
            document.getElementById(passwordVariable).focus();
            return false;
        }
    }
    return true;
}

function KeycheckAlphaNumeric(e)
{
    var _dom = 0;
    _dom = document.all ? 3 : (document.getElementById ? 1 : (document.layers ? 2 : 0));
    if (document.all)
        e = window.event; // for IE
    var ch = '';
    var KeyID = '';
    //alert(_dom);
    if (_dom == 2) {                     // for NN4
        //alert(e.which);
        if (e.which > 0)
            ch = '(' + String.fromCharCode(e.which) + ')';
        KeyID = e.which;
    }
    else
    {
        if (_dom == 3) {                   // for IE
            KeyID = (window.event) ? event.keyCode : e.which;
        }
        else {                       // for Mozilla
            //alert('Mozilla:' + e.charCode);
            if (e.charCode > 0)
                ch = '(' + String.fromCharCode(e.charCode) + ')';
            KeyID = e.charCode;
        }
    }
    if ((KeyID >= 31 && KeyID <= 44) || (KeyID >= 46 && KeyID <= 47) || (KeyID >= 58 && KeyID <= 64) || (KeyID >= 65 && KeyID <= 96) || (KeyID >= 123 && KeyID <= 126))
    {
        //alert("hello");
        return false;
    }

    return true;
}


//function checkValidDispOrder(displayorderval)
//{
//    if(displayorderval=='0' || displayorderval=='')
//    {
//        $('#asignbannerdisplay').css('display', 'block');
//        return false;
//    }
//    else
//    {
//        return true;
//    }
//}

function checkValidDispOrder(displayorderval, myArray)
{
    // alert(myArray);

    var l;
    for (var l = 0; l < myArray.length; l = l + 1) {
        if (myArray[ l ] == '')
        {
            $('#asignbanner1').css('display', 'block');
            //                     return false;
        }

    }

    if (displayorderval == 0 || displayorderval == "")
    {
        $('#asignbannerdisplay').css('display', 'block');

        return false;
    }

    else
    {
        return true;
    }

}

function checkValidName(name, requiredArray)
{
    var RegExp = /^(([\w]+:)?\/\/)?(([\d\w]|%[a-fA-f\d]{2,2})+(:([\d\w]|%[a-fA-f\d]{2,2})+)?)?([\d\w][-\d\w]{0,253}[\d\w]\.)+[\w]{2,4}(:[\d]+)?(\/([-+_~.\d\w]|%[a-fA-f\d]{2,2})*)*(\?(&?([-+_~.\d\w]|%[a-fA-f\d]{2,2})=?)*)?(#([-+_~.\d\w]|%[a-fA-f\d]{2,2})*)?$/;
    var l;
    for (var l = 0; l < requiredArray.length; l = l + 1) {
        if (requiredArray[ l ] == '')
        {
            $('#asignbanner1').css('display', 'block');
            //return false;
        }

    }

    if (RegExp != requiredArray[ l ])
    {
        $('#asignbanner1').css('display', 'block');
    }
    else
    {
        return false;
    }

    if (name == "")
    {
        $('#asignbanner1').css('display', 'block');

        return false;
    }
    else
    {
        return true;
    }
}

function checkValidDispOrder(displayorderval, requiredArray)
{
    //alert(requiredArray);
    var RegExp = /^(([\w]+:)?\/\/)?(([\d\w]|%[a-fA-f\d]{2,2})+(:([\d\w]|%[a-fA-f\d]{2,2})+)?)?([\d\w][-\d\w]{0,253}[\d\w]\.)+[\w]{2,4}(:[\d]+)?(\/([-+_~.\d\w]|%[a-fA-f\d]{2,2})*)*(\?(&?([-+_~.\d\w]|%[a-fA-f\d]{2,2})=?)*)?(#([-+_~.\d\w]|%[a-fA-f\d]{2,2})*)?$/;
    var l;
    for (var l = 0; l < requiredArray.length; l = l + 1) {
        if (requiredArray[ l ] == '' || requiredArray[ l ] == 'http://www.')
        {
            $('#asignbanner1').css('display', 'block');
            // return false;
        }

        if (RegExp != requiredArray[ l ])
        {
            $('#asignbanner1').css('display', 'block');

        }


    }

    if (displayorderval == 0 || displayorderval == "")
    {
        $('#asignbannerdisplay').css('display', 'block');

        return false;
    }

    else
    {
        return true;
    }




}

function checkCKEDITOR(fieldname) {
    var msg = CKEDITOR.instances[fieldname].getData();
    var regex = /(<([^>]+)>)/ig;
    var result1 = msg.replace(regex, '');
    var result2 = result1.replace(/&nbsp;/g, "");
    var result = trim(result2);
    var messageLength = result.length;
    if (messageLength == 0) {
        return false;
    } else {
        return true;
    }
}

function Check_mobile_number(evt) {
    evt = (evt) ? evt : window.event;
    var charCode = (evt.which) ? evt.which : evt.keyCode;
    if (charCode > 32 && (charCode < 48 || charCode > 57) && (charCode < 40 || charCode > 41) && (charCode < 43 || charCode > 43) && (charCode < 45 || charCode > 45)) {
        return false;
    }
    return true;
}

function disporderspinner(id, dir, url, urlwithpara, int_glcode, fkpages, fk_type, fkaddpages, fk_category)
{
    if (dir == 'down')
    {
        oldorder = document.getElementById(id).value;
        neworder = eval(oldorder) + eval(1);
        updateDisplayOrder(int_glcode, neworder, oldorder, fkpages, url, fk_type, fkaddpages, fk_category);
        SendGridBindRequest(urlwithpara, 'gridbody', 'ST');
    }
    else if (dir == 'up')
    {
        oldorder = document.getElementById(id).value;
        neworder = eval(oldorder) - eval(1);
        updateDisplayOrder(int_glcode, neworder, oldorder, fkpages, url, fk_type, fkaddpages, fk_category);
        SendGridBindRequest(urlwithpara, 'gridbody', 'ST');
    }
}

function UpdatePublishView(module, tablename, fieldname, intglcode, othertable, urls, imgpath)
{

    xmlHttp = GetXmlHttpObject();
    if (xmlHttp == null)
    {
        alert("Your browser does not support XMLHTTP!");
        return;
    }


    var path = document.getElementById('tick-' + intglcode).src;
    var file_a = path.substring(path.lastIndexOf("/") + 1, path.length);
    var value;
    if (file_a == 'unblock.png')
    {
        value = '1';
    }
    else if (file_a == 'block.png')
    {
        value = '0';
    }
    if (othertable == '')
    {
        var url = urls + module + "/UpdatePublishview?tablename=" + tablename + "&fieldname=" + fieldname + "&value=" + value + "&id=" + intglcode;
         }
    else
        var url = urls + module + "user_management/accesscontrol/UpdatePublishview?tablename=" + tablename + "&fieldname=" + fieldname + "&value=" + value + "&id=" + intglcode + "&othertablename=" + othertable;
    
    xmlHttp.onreadystatechange = function ()
    {
        if (xmlHttp.readyState == 1)
        {
//            SetBackground();
        }
        if ((xmlHttp.readyState == 4 || xmlHttp.readyState == "complete") && (xmlHttp.status == 200))
        {
            var result = xmlHttp.responseText;
            if (result == 1)
            {
                
                if (value == '0')
                {
                    document.getElementById('tick-' + intglcode).src = imgpath + 'admin-media/images/unblock.png';
                    if (document.getElementById('tick-' + intglcode).title == "UnSubscribed")
                        document.getElementById('tick-' + intglcode).title = 'Subscribed';
                    else
                        document.getElementById('tick-' + intglcode).title = 'Block me';
                }
                else
                {
                    document.getElementById('tick-' + intglcode).src = imgpath + 'admin-media/images/block.png';
                    if (document.getElementById('tick-' + intglcode).title == "Subscribed")
                        document.getElementById('tick-' + intglcode).title = 'UnSubscribed';
                    else
                        document.getElementById('tick-' + intglcode).title = 'Unblock Me';
                }
                location.reload();
            }
            else
            {
                alert("Sorry could not update...");
            }
//            UnsetBackground();
        }
    };
//     alert(url);
    xmlHttp.open("GET", url, true);
    xmlHttp.send(null);
}
function updateDisplayOrder(int_glcode, neworder, oldorder, fkpages, url, fk_type, fkaddpages, fk_category)
{

    jQuery.ajax({
        type: "POST",
        url: url + "orderupdate",
        data: {
            "uid": int_glcode,
            "neworder": neworder,
            "oldorder": oldorder,
            "fkpages": fkpages,
            "chr_bannertype_flag": fk_type,
            "fk_addpages": fkaddpages,
            "fk_category": fk_category
        },
        async: false,
        success: function (result)
        {
            //$("#gridbody").replaceWith(result);    
            // alert(result);
            //document.getElementById('gridbody').innerHTML = result;
        }
    });

}

