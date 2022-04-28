<template>
    <div>
        <div class="card-container">
        <a-tabs type="card" :animated="true" @change="callback">
            <a-tab-pane tab="歌手审核" key="1">
                <a-row>
                    <a-col :span="8"><span style="margin-left: 10%">用户</span></a-col>
                        <a-col :span="8">  <span style="margin-left: 40%">国籍</span></a-col>
                            <a-col :span="8"> <span style="margin-left: 60%">审核状态</span></a-col>
                    <a-divider></a-divider>
                    <a-col v-for="(review,index) in reviewList" :key="index" class="reviewList" @click="goAdminReview(review)">
                        <a-col :span="8"> <span style="margin-left: 10%;">{{review.username}}</span></a-col>
                        <a-col :span="8"><span style="margin-left: 40%">{{review.country}}</span></a-col>
                        <a-col :span="8"> <a-tag style="margin-left: 60%" color="geekblue" v-show="review.result==='0'">未审核</a-tag></a-col>
                        <a-col :span="8"><a-tag style="margin-left: 60%" color="green" v-show="review.result==='1'">审核成功</a-tag></a-col>
                        <a-col :span="8"> <a-tag style="margin-left: 60%" color="volcano" v-show="review.result==='-1'">审核失败</a-tag></a-col>
                        <a-divider></a-divider>
                    </a-col>
                </a-row>
            </a-tab-pane>
            <a-tab-pane tab="用户管理" key="2">
                <a-button type="primary" block style="margin-bottom: 30px" @click="addUserModal=true">添加用户</a-button>
                <a-modal title="添加用户"
                         :visible="addUserModal"
                         :closable="false">
                    <template slot="footer">
                        <a-button @click="addUserModal=false">取消</a-button>
                        <a-button type="primary" @click="submitAddUser" >
                            提交
                        </a-button>
                    </template>
                    <a-form-model :model="addUserForm" ref="addUserForm" :rules="addUserRules">
                        <a-form-model-item label="用户名"  prop="username">
                            <a-input v-model="addUserForm.username"  />
                        </a-form-model-item>
                        <a-form-model-item label="密码"  prop="password">
                            <a-input type="password" v-model="addUserForm.password"  />
                        </a-form-model-item>
                        <a-form-model-item label="性别" prop="sex">
                            <a-radio-group v-model="addUserForm.sex">
                                <a-radio value="男">男</a-radio>
                                <a-radio value="女">女</a-radio>
                            </a-radio-group>
                        </a-form-model-item>
                        <a-form-model-item label="生日" prop="birth">
                            <a-date-picker v-model="addUserForm.birth"/>
                        </a-form-model-item>
                    </a-form-model>
                </a-modal>
                <a-table :dataSource="userData">
                    <a-table-column width="20%" title="序号" dataIndex="key" key="key" />
                    <a-table-column width="20%" title="用户名" dataIndex="username" key="username" />
                    <a-table-column width="20%" title="性别" dataIndex="sex" key="sex" />
                    <a-table-column width="20%" title="生日" dataIndex="birth" key="birth">
                        <template slot-scope="birth">
                            <span>{{birth}}</span>
                        </template>
                    </a-table-column>
                    <a-table-column width="20%" title="操作" key="action">
                        <template slot-scope="user">
                            <span>
                                <a @click="openUpUserModal(user)">修改</a>
                                <a-divider type="vertical" />
                                <a-popconfirm
                                        title="确认删除吗？"
                                        @confirm="deleteUser(user.userid)"
                                        okText="Yes"
                                        cancelText="No"
                                >
                                    <a href="#">删除</a>
                                </a-popconfirm>
                            </span>
                        </template>
                    </a-table-column>
                </a-table>
                <a-modal
                        :closable="false"
                        title="修改个人信息"
                        :visible="upUserModal"
                >
                    <template slot="footer">
                        <a-button @click="closeUpUserModal">取消</a-button>
                        <a-button type="primary" @click="updateUser" >
                            提交
                        </a-button>
                    </template>
                    <a-form-model :model="upUserForm" ref="upUserForm" :rules="upUserRules">
                        <a-form-model-item label="用户名"  prop="username">
                            <a-input v-model="upUserForm.username"  />
                        </a-form-model-item>
                        <a-form-model-item label="性别" prop="sex">
                            <a-radio-group v-model="upUserForm.sex">
                                <a-radio value="男">男</a-radio>
                                <a-radio value="女">女</a-radio>
                            </a-radio-group>
                        </a-form-model-item>
                        <a-form-model-item label="生日" prop="birth">
                            <a-date-picker v-model="upUserForm.birth"/>
                        </a-form-model-item>
                    </a-form-model>
                </a-modal>
            </a-tab-pane>
            <a-tab-pane tab="曲目管理" key="3">
                <a-table :dataSource="musicData">
                    <a-table-column width="20%" title="序号" dataIndex="key" key="key" />
                    <a-table-column width="20%" title="音乐名" dataIndex="musicname" key="musicname" />
                    <a-table-column width="20%" title="音乐人" dataIndex="singername" key="singername" />
                    <a-table-column width="20%" title="热度" dataIndex="hot" key="hot">
                        <template slot-scope="hot">
                            <span>{{hot}}</span>
                        </template>
                    </a-table-column>
                    <a-table-column width="20%" title="操作" key="action">
                        <template slot-scope="music">
                            <span>
                                <a @click="openUpMusicModal(music)">修改</a>
                                <a-divider type="vertical" />
                                <a-popconfirm
                                        title="确认删除吗？"
                                        @confirm="deleteMusic(music)"
                                        okText="Yes"
                                        cancelText="No"
                                >
                                    <a href="#">删除</a>
                                </a-popconfirm>
                            </span>
                        </template>
                    </a-table-column>
                </a-table>
                <a-modal
                        :closable="false"
                        title="修改音乐信息"
                        :visible="upMusicModal"
                >
                    <template slot="footer">
                        <a-button @click="upMusicModal=false">取消</a-button>
                        <a-button type="primary" @click="updateMusic" >
                            提交
                        </a-button>
                    </template>
                    <a-form-model :model="upMusicForm" ref="upMusicForm" :rules="upMusicRules">
                        <a-form-model-item label="音乐名"  prop="musicname">
                            <a-input v-model="upMusicForm.musicname"  />
                        </a-form-model-item>
                        <a-form-model-item label="歌手名" prop="singername">
                            <a-select :defaultValue="upMusicForm.singername" style="width: 120px" @change="selectNewSinger">
                                <a-select-option v-for="(singer,index) in singerData" :value="singer.singerid" :key="index">{{singer.singername}}</a-select-option>
                            </a-select>
                        </a-form-model-item>
                    </a-form-model>
                </a-modal>
            </a-tab-pane>
        </a-tabs>
        </div>
    </div>
</template>

<script>
    import moment from 'moment'
    export default {
        name: "AdminPage",
        data(){
            return{
                reviewList:[],
                userData:[],
                musicData:[],
                singerData:[],
                addUserModal:false,
                upUserModal:false,
                upMusicModal:false,
                addUserForm:{
                    username:'',
                    password:'',
                    sex:'',
                    birth:null,
                },
                upUserForm:{
                    userid:'',
                    username:'',
                    password:'',
                    sex:'',
                    birth:null,
                },
                addUserRules:{
                    username:[
                        {required:true,message:'请输入用户名',trigger:'change'},
                        {min:3,max:10, message: '用户名应该在3-10位', trigger: 'change'}
                    ],
                    password:[
                        {required:true,message:'请输入密码',trigger:'change'},
                        {min:6,max:14, message: '密码应该在6-14位', trigger: 'change'}
                    ],
                    sex:[
                        {required:true,message:'请选择性别',trigger:'change'},
                    ],
                    birth:[
                        {required:true,message:'请填写生日',trigger:'change'},
                    ]
                },
                upMusicRules:{
                  musicname:[{required:true,message:'请输入音乐名',trigger:'change'}],
                  singername:[{required:true,message:'请输入歌手名',trigger:'change'}]
                },
                upMusicForm:{
                  musicid:'',
                    musicname:'',
                    singerid:'',
                  singername:'',
                },
                upUserRules:{
                    username:[
                        {required:true,message:'请输入用户名',trigger:'change'},
                        {min:3,max:10, message: '用户名应该在3-10位', trigger: 'change'}
                    ],
                    password:[
                        {required:true,message:'请输入密码',trigger:'change'},
                        {min:6,max:14, message: '密码应该在6-14位', trigger: 'change'}
                    ],
                    sex:[
                        {required:true,message:'请选择性别',trigger:'change'},
                    ],
                    birth:[
                        {required:true,message:'请填写生日',trigger:'change'},
                    ]
                },
            }
        },
        created(){
            this.getReview();
        },
        methods:{
            selectNewSinger(value){
              this.upMusicForm.singerid=value;
            },
            openUpMusicModal(music){
                this.upMusicForm=music;
                this.upMusicModal=true;
            },
            updateMusic(){
                this.$refs['upMusicForm'].validate(valid=>{
                    if(valid){
                        let music=this.$qs.stringify(this.upMusicForm);
                        this.axios.post('/user/updateMusic',music)
                            .then(res=>{
                                if(res.data.data){
                                    this.$message.success('修改成功');
                                    this.upMusicModal=false;
                                    this.getAllMusic();
                                }else {
                                    this.$message.error('修改失败')
                                }
                            }).catch(err=>{
                            console.log(err);
                        })
                    }else{
                        this.$message.error('请完善信息');
                        return false;
                    }});
            },
            deleteMusic(music){
                music=this.$qs.stringify(music);
                this.axios.post('/user/deleteMusic',music)
                .then(res=>{
                    if(res.data.data){
                        this.$message.success("删除成功");
                        this.getAllMusic();
                    }else {
                        this.$message.error("删除失败");
                    }
                }).catch(err=>{
                    console.log(err);
                })
            },
            deleteUser(userid){
                this.axios.get('/user/deleteUser?userid='+userid)
                .then(res=>{
                    if(res.data.data){
                        this.$message.success("成功删除");
                        this.getAllUser();
                    }else {
                        this.$message.error("删除失败");
                    }
                }).catch(err=>{
                    console.log(err);
                })
            },
            openUpUserModal(user){
                this.upUserForm=user;
                this.upUserForm.birth=moment(user.birth,"YYYY-MM-DD")
                this.upUserModal=true;
            },
            closeUpUserModal(){
                this.getAllUser();
              this.upUserModal=false;
            },
            updateUser(){
                this.$refs['upUserForm'].validate(valid=>{
                    if(valid){
                        this.axios.post('/user/updateUser',this.upUserForm)
                            .then(res=>{
                                if(res.data.data){
                                    this.$message.success("修改成功");
                                    this.upUserModal=false;
                                    this.getAllUser();
                                }else {
                                    this.$message.error("修改失败");
                                }
                            }).catch(err=>{
                            console.log(err);
                        })
                    }else {
                        this.$message.error('请完善信息');
                        return false;
                    }});
            },
            submitAddUser(){
                this.$refs['addUserForm'].validate(valid=>{
                    if(valid){
                        for(let u of this.userData){
                            if(u.username===this.addUserForm.username){
                                this.$message.error("此用户名已被占用");
                                return false;
                            }
                        }
                    let user=this.addUserForm;
                        this.axios.post('/user/addUser',user)
                            .then(res=>{
                                console.log(res);
                                if(res.data.data){
                                    this.$message.success("添加成功");
                                    this.addUserModal=false;
                                    this.$refs['addUserForm'].resetFields();
                                    this.getAllUser();
                                }else {
                                    this.$message.error("添加失败");
                                }
                            }).catch(err=>{
                            console.log(err);
                        })
                    }else {
                        this.$message.error("请完善信息");
                        return false;
                    }
                })
            },
            getAllUser(){
                this.axios.get('/user/getAllUser')
                    .then(res=>{
                        let i=0;
                        let allUser=res.data.data
                        for (let user of allUser){
                            user.key=i;
                            i++
                        }
                        this.userData=allUser
                    }).catch(err=>{
                    console.log(err);
                })
            },
            getAllMusic(){
                this.axios.get('/user/getAllMusic')
                    .then(res=>{
                       let i=0;
                       let allMusic=res.data.data;
                       for(let music of allMusic){
                           music.key=i;
                           i++
                       }
                       this.musicData=allMusic
                        console.log(this.musicData)
                    }).catch(err=>{
                    console.log(err);
                })
            },
            getAllSinger(){
              this.axios.get('/user/getAllSinger')
              .then(res=>{
                  this.singerData=res.data.data;
              }).catch(err=>{
                  console.log(err);
              })
            },
            goAdminReview:function(review){
                this.$router.push({path:'/adminReview',query:{'review':JSON.stringify(review)}})
            },
            callback(key) {
                console.log(key);
                if(key==="1"){
                    this.getReview();
                }if(key==="2"){
                this.getAllUser()
                }if(key==="3"){
                this.getAllMusic();
                this.getAllSinger();
                }
            },
            getReview(){
                this.axios.get('/user/getReviewList')
                .then(res=>{
                    this.reviewList=res.data.data;
                    console.log(this.reviewList)
                }).catch(err=>{
                    console.log(err);
                })
            }
        }
    }
</script>

<style scoped>
    .card-container {
        background: #f5f5f5;
        overflow: hidden;
        padding: 24px;
    }
    .card-container > .ant-tabs-card > .ant-tabs-content {
        height: 120px;
        margin-top: -16px;
    }

    .card-container > .ant-tabs-card > .ant-tabs-content > .ant-tabs-tabpane {
        background: #fff;
        padding: 16px;
    }

    .card-container > .ant-tabs-card > .ant-tabs-bar {
        border-color: #fff;
    }

    .card-container > .ant-tabs-card > .ant-tabs-bar .ant-tabs-tab {
        border-color: transparent;
        background: transparent;
    }

    .card-container > .ant-tabs-card > .ant-tabs-bar .ant-tabs-tab-active {
        border-color: #fff;
        background: #fff;
    }
    .reviewList{
        cursor: pointer;
    }
    :hover.reviewList{
        color: #450a7c;
    }
</style>