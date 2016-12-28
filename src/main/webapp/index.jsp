<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>ExtJs的练习</title>
<!-- extjs的样式表 -->
<link type="text/css" href="extjs/resources/css/ext-all.css" rel="stylesheet" />
<!-- extjs的核心js文件 -->
<script type="text/javascript" src="extjs/ext-all-debug.js"></script>
<script type="text/javascript" src="extjs/ext-lang-zh_CN.js"></script>
<script type="text/javascript">
// 保证页面元素加载完毕后执行js代码
Ext.onReady(function(){

	var states = Ext.create('Ext.data.Store', {
	    fields: ['id', 'name'],
	    proxy: {
	         type: 'ajax',
	         url: 'http://localhost/lianxi/user/queryUserCombox',
	         reader: {
	             type: 'json'
	         }
	     },

	     autoLoad: true
	});

	// Create the combo box, attached to the states data store
	// 创建一个可视化的下拉框，Ext.form.ComboBox
	Ext.create('Ext.form.ComboBox', {
		// 标签名
	    fieldLabel: 'Choose State',
	    // 定义仓库，对应上面定义好的仓库
	    store: states,
	    // 从本地加载数据
	    queryMode: 'local',
	    // 显示名，引用的是字段的定义name
	    displayField: 'name',
	    // 值定义，引用的是字段abbr
	    valueField: 'id',
	    // 根据html元素的id渲染到页面
	    renderTo: "comboId",
	    listeners:{
	    	// *定义选择事件
	    	select : function(combo, records, eOpts){
	    		alert(this.getValue());
	    	}
	    }
	});	
	var store = Ext.create('Ext.data.Store', {
	    fields:['name', 'id', 'sex','age'],
	    pageSize: 3, // 每页的条目数量	   
	    proxy: {
	    	// 从本地读取数据
	        //type: 'memory',
	     	// 从服务器读取数据
	        type: 'ajax',
	     	// 请求地址
	        url: 'http://localhost/lianxi/user/queryUserList',
	        reader: {
	        	// 使用json格式进行解析
	            type: 'json',
	            // 指定根元素
	            root: 'rows',
	            // 总数的引用
	            totalProperty: 'total'
	        }
	    },

	     autoLoad: true
	});


	Ext.create('Ext.grid.Panel', {

	    title: 'Simpsons',

	    store: store,

	    columns: [
	        // dataIndex引用的是store中fields的配置
	        { header: 'Id', dataIndex: 'id' },
	        { header: 'Name',  dataIndex: 'name' },
	        { header: 'Sex', dataIndex: 'sex'  ,

	        	renderer : function(value){
	        		if(value == '1'){
	        			return '男';
	        		}else{
	        			return '女';
	        		}
	        }},
	        { header: 'Age', dataIndex: 'age'}
	    ],
	
	    height: 400,
	    width: 400,
	    dockedItems: [{
	        xtype: 'pagingtoolbar',
	        store: store,   
	        dock: 'bottom',
	        displayInfo: true
	    }],
	  
	    renderTo: 'gridId',

	    listeners :{
	    	select:function(model, record, index){
	    		alert(record.data.name);
	    	}
	    }
	});
});




</script>
</head>
<body>
	<h1>下拉框111</h1>
	<div id="comboId"></div>
	
	<h1>列表111</h1>
	<div id="gridId"></div>
</body>
</html>
