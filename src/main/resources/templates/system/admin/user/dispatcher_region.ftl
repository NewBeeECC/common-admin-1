<style>
    ul.ztree {
        margin-top: 10px;
        border: 1px solid #617775;
        background: #f0f6e4;
        width: 220px;
        height: 360px;
        overflow-y: scroll;
        overflow-x: auto;
    }
</style>
<div class="row">
    <div class="col-md-12">
        <div class="zTreeDemoBackground">
            <ul id="regionTree" class="ztree"></ul>
        </div>
        <div class="modal-footer">
            <div class="pull-right">
                <button type="button" class="btn btn-default btn-sm" data-dismiss="modal"><i class="fa fa-close"></i>取消</button>
                <button type="button" class="btn btn-primary btn-sm" onclick="dispatchRegion(${user_id});"><i class="fa fa-save"></i>保存</button>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript" src="other/zTree/js/jquery.ztree.core.js"></script>
<script type="text/javascript" src="other/zTree/js/jquery.ztree.excheck.js"></script>
<link rel="stylesheet" type="text/css" href="other/zTree/css/zTreeStyle/zTreeStyle.css"/>
<script type="text/javascript">
    var checkNodesList=new Array();
    function dispatchRegion(user_id) {
        $.ajax({
            url: '/region/save',
            type: 'post',
            dataType: 'text',
            traditional:true,
            data: {
                "regionId":checkNodesList,
                "userId":user_id
            },
            success: function (data) {
                var json = JSON.parse(data);
                if (json.status) {
                    $("#lgModal").modal('hide');
                    alertMsg("添加成功", "success");
                    reloadTable(list_ajax, "#roleTime", "#rolePremise");
                } else {
                    alertMsg("添加失败:" + json.msg, "success");
                }
            }
        })
    }
    var regionSetting = {
        check: {
            enable: true
        },
        view: {
            selectedMulti: false
        },
        data: {
            simpleData: {
                enable: true
            }
        },
        callback: {
            onCheck: onRegionCheck
        }
    };
    var zNodes = ${zNodes};
    function onRegionCheck() {
        console.log(".......................");
        var zTree = $.fn.zTree.getZTreeObj("regionTree");
        var nodes = zTree.getCheckedNodes(true);
        for (var i = 0, l = nodes.length; i < l; i++) {
            var id = nodes[i].id;
            checkNodesList.push(id);
        }
        console.log(JSON.stringify(nodes));
    }
    $(document).ready(function(){
        $.fn.zTree.init($("#regionTree"), regionSetting, zNodes);
    });
</script>