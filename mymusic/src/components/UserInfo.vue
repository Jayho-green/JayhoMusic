<template>
    <div>
       <div style="font-size: 22px;margin-top: 20px">个人信息</div>
        <a-divider></a-divider>
        <div style="font-size: 17px;margin-top: 20px;margin-left: 20px;">
            <span> 身份:</span>
            <span style="margin-left: 40px" v-show="loginUser.rowid==='0'">普通用户</span>
            <span style="margin-left: 40px" v-show="loginUser.rowid==='1'">管理员</span>
            <span style="margin-left: 40px" v-show="loginUser.rowid==='2'">音乐人</span>
        </div>
        <div style="font-size: 17px;margin-top: 20px;margin-left: 20px">
            <span> 用户名:</span><span style="margin-left: 22px">{{loginUser.username}}</span>
        </div>
        <div style="font-size: 17px;margin-top: 20px;margin-left: 20px">
            <span> 性别:</span><span style="margin-left: 40px">{{loginUser.sex}}</span>
        </div>
        <div style="font-size: 17px;margin-top: 20px;margin-left: 20px">
            <span> 生日:</span><span style="margin-left: 40px">{{loginUser.birth}}</span>
        </div>
        <a-button type="primary" size="small" style="margin-top: 30px;font-size: 12px;margin-left: 17px" @click="openUserInfoModal">修改信息</a-button>
        <a-modal
                :closable="false"
                title="修改个人信息"
                :visible="userInfoModal"
        >
            <template slot="footer">
                <a-button @click="userInfoModal=false">取消</a-button>
                <a-button type="primary" @click="upUserInfo" :loading="upUserLoading">
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
        <a-button type="danger" size="small" style="margin-left: 30px;font-size: 12px" @click="upPassModal=true">修改密码</a-button>
        <a-modal
                :closable="false"
                title="修改密码"
                :visible="upPassModal"
        >
            <template slot="footer">
                <a-button @click="upPassModal=false">取消</a-button>
                <a-button type="primary" @click="upPass" :loading="upPassLoading">
                    提交
                </a-button>
            </template>
            <a-form-model :model="upPassForm" ref="upPassForm" :rules="upPassRules">
                <a-form-model-item label="原密码"  prop="oldPass">
                    <a-input type="password" v-model="upPassForm.oldPass" />
                </a-form-model-item>
                <a-form-model-item label="新密码" prop="password">
                    <a-input type="password" v-model="upPassForm.password" />
                </a-form-model-item>
                <a-form-model-item label="确认密码" prop="reNewPass">
                    <a-input type="password" v-model="upPassForm.reNewPass" />
                </a-form-model-item>
            </a-form-model>
        </a-modal>
        <a-button  v-show="loginUser.rowid==='1'" size="small" style="margin-left: 30px;font-size: 12px" @click="goAdminPage">管理面板</a-button>
        <a-button  v-show="loginUser.rowid==='0'" size="small" style="margin-left: 30px;font-size: 12px" @click="singerRequest">申请音乐人</a-button>
        <a-button  v-show="loginUser.rowid==='2'" size="small" style="margin-left: 30px;font-size: 12px" @click="goUpLoadMusic">发布音乐</a-button>
        <div v-show="collectMusic.length>0" style="font-size: 22px;margin-top: 100px">音乐收藏</div>
        <a-divider ></a-divider>
        <a-row :gutter="[16,16]">
            <a-col :span="6"  v-for="(music,index) in collectMusic" :key="index">
                <a-card hoverable @click="toMusicInfo(music)" style="width: 200px">
                    <img :alt="music.musicname" :src="music.musicimg"  slot="cover" style="height: 200px"/>
                    <a-card-meta>
                        <template slot="description"
                        >
                            <div style="text-align: center">{{music.musicname}}</div>
                            <div style="text-align: center;margin-top: 10px">收藏日期</div>
                            <div style="text-align: center;">{{music.date}}</div>
                        </template>
                    </a-card-meta>
                </a-card>
            </a-col>
        </a-row>

        <div v-show="collectList.length>0" style="font-size: 22px;margin-top: 100px">歌单收藏</div>
        <a-divider v-show="collectList.length>0"></a-divider>
        <a-row :gutter="[16,16]">
            <a-col :span="6"  v-for="(list,index) in collectList" :key="index">
                <a-card hoverable @click="toListInfo(list.listid)" style="width: 200px">
                    <img :alt="list.listname" :src="list.listimg"  slot="cover" style="height: 200px"/>
                    <a-card-meta>
                        <template slot="description">
                            <div style="text-align: center">{{list.listname}}</div>
                        </template>
                    </a-card-meta>
                </a-card>
            </a-col>
        </a-row>

    </div>


</template>

<script>
    import moment from 'moment'
    export default {
        name: "UserInfo",
        data(){
            var validateOldPass = (rule, value, callback) => {
                if (value === '') {
                    callback(new Error('请输入原密码'));
                } else {
                    let user=JSON.parse(localStorage.getItem('loginUser'));
                    let password=user.password;
                    if (this.upPassForm.reNewPass !== '') {
                        this.$refs.upPassForm.validateField('reNewPass');
                    }if(password!==value){
                        callback(new Error('原密码错误'));
                    }
                    callback();
                }
            };
            var validateNewPass = (rule, value, callback) => {
                if (value === '') {
                    callback(new Error('请输入新密码'));
                } else {
                    if (this.upPassForm.reNewPass !== '') {
                        this.$refs.upPassForm.validateField('reNewPass');
                    }
                    if(value.length<6||value.length>14){
                        callback(new Error('密码长度在6-14个字符之间'));
                    }
                    if(value===this.upPassForm.oldPass){
                        callback(new Error('新密码不能与原密码一致'));
                    }
                    callback();
                }
            };
            var validateReNewPass = (rule, value, callback) => {
                if (value === '') {
                    callback(new Error('请再次输入新密码'));
                } else if (value !== this.upPassForm.password) {
                    callback(new Error('两次输入密码不一致!'));
                } else {
                    callback();
                }
            };
            return{
                loginUser:{},
                collectMusic:[],
                collectList:[],
                userInfoModal:false,
                upPassModal:false,
                upUserLoading:false,
                upPassLoading:false,
                upUserForm:{
                    userid:JSON.parse(localStorage.getItem('loginUser')).userid,
                    username:JSON.parse(localStorage.getItem('loginUser')).username,
                    sex:JSON.parse(localStorage.getItem('loginUser')).sex,
                    birth:moment(JSON.parse(localStorage.getItem('loginUser')).birth,'YYYY-MM-DD'),
                    rowid:JSON.parse(localStorage.getItem('loginUser')).rowid,
                    oldusername:JSON.parse(localStorage.getItem('loginUser')).username,
                },
                upUserRules:{
                    username:[
                        {required:true,message:'请输入用户名',trigger:'change'},
                        {min:3,max:10, message: '用户名应该在3-10位', trigger: 'change'}
                        ],
                    sex:[
                        {required:true,message:'请选择性别',trigger:'change'},
                    ],
                    birth:[
                        {required:true,message:'请填写生日',trigger:'change'},
                    ]
                },
                upPassRules: {
                    oldPass: [
                        { validator: validateOldPass, trigger: 'change' }
                    ],
                    password: [
                        { validator: validateNewPass, trigger: 'change' }
                    ],
                    reNewPass: [
                        { validator: validateReNewPass, trigger: 'change' }
                    ],
                },
                upPassForm:{
                    userid:JSON.parse(localStorage.getItem('loginUser')).userid,
                    oldPass:'',
                    password:'',
                    reNewPass:''
                }
            }
        },
        mounted(){
            this.loginUser=JSON.parse(localStorage.getItem('loginUser'));
            this.getCollect();
        },
        methods:{
            goUpLoadMusic:function(){
              this.$router.push('/UploadMusic')
            },
            goAdminPage:function(){
                this.$router.push('/adminPage');
            },
            singerRequest:function(){
                this.$router.push('/singerRequest');
            },
            upPass:function(){
                this.$refs['upPassForm'].validate(valid=>{
                    if(valid){
                        this.upPassLoading=true;
                        let upPassForm=this.$qs.stringify(this.upPassForm);
                        this.axios.post('/user/updatePassword',upPassForm)
                        .then(res=>{
                            if(res.data.data){
                                this.$message.success('修改成功');
                                this.$router.push('/login');
                                localStorage.clear();
                                sessionStorage.clear();
                            }else{
                                this.$message.error("修改失败");
                            }
                        }).catch(err=>{
                            console.log(err);
                        })
                    }else {
                        this.$message.error("请完善信息!");
                        return false;
                    }
                });
            },
            upUserInfo:function(){
              //setInterval();用法和setTimeout类似，但是是周期性调用函数，setTimeout是延迟调用函数
                this.$refs['upUserForm'].validate(valid=>{
                    if(valid){
                        this.upUserLoading=true;
                        let user=this.upUserForm;
                        this.axios.post('/user/updateUser',user)
                        .then(res=>{
                            if(res.data.data){
                                this.upUserLoading=false;
                                this.$router.push('/login');
                                this.$message.success('修改成功，请重新登录！');
                            }else{
                                this.$message.error('修改失败');
                            }
                        }).catch(err=>{
                            console.log(err);
                        })
                    }else {
                        this.$message.error('请完善用户信息!');
                        return false;
                    }
                })
            },
            openUserInfoModal:function(){
              this.userInfoModal=true;

            },
            toMusicInfo:function (music) {
                this.$router.push({path:'/musicInfo',query:{music:JSON.stringify(music)}})
            },
            getCollect:function () {
                this.axios.get('/user/getCollect?userid='+this.loginUser.userid)
                .then(res=>{
                    this.collectMusic=res.data.data.collectMusic;
                    this.collectList=res.data.data.collectList;
                    console.log(res)
                }).catch(err=>{
                    console.log(err);
                })
            },
            toListInfo(listid){
                this.$router.push({path:'/listInfo',query:{'listid':listid}})
            }
        }
    }
</script>

<style scoped>

</style>