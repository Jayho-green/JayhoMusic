<template>
    <div>
        <div v-show="existSinger==='无'">
        <span style="font-size: 25px">开启音乐人之路</span>
        <a-divider></a-divider>
        <a-alert
                message="注意！"
                description="请认真填写以下信息，告诉我们你想成为音乐人的原因，并提交你的作品，如果成功，以下信息将作为你的音乐人信息，审核一般在24小时之内完成。"
                type="info"
                showIcon
        />

<a-form-model layout="horizontal" style="margin-top: 30px" :model="singerReqForm" ref="singerReqForm" :rules="singerReqRules">
    <a-form-model-item label="你来自哪个国家"  prop="details" >
        <a-input placeholder="..." v-model="singerReqForm.country" size="large"/>
    </a-form-model-item>
    <a-form-model-item label="为什么想当音乐人" prop="reason">
        <a-textarea placeholder="......" v-model="singerReqForm.reason" :rows="4" />
    </a-form-model-item>
    <a-form-model-item label="你的简介"  prop="details">
        <a-textarea placeholder="......" v-model="singerReqForm.details" :rows="4" />
    </a-form-model-item>
</a-form-model>
        <a-upload-dragger
                name="file"
                :multiple="true"
                accept=".jpg, .jpeg, .png, .jfif, .mp3, .ogg"
                action="http://localhost:8088/api/user/uploadSingerReq"
                @change="handleChange"
                @reject="handleReject"
        >
            <p class="ant-upload-drag-icon">
                <a-icon type="inbox" />
            </p>
            <p class="ant-upload-text">点击或拖拽文件上传</p>
            <p class="ant-upload-hint">
              请在此处上传您的照片以及您的作品(请不要上传大于5m的作品)
            </p>
        </a-upload-dragger>
        <a-alert
                style="margin-top: 30px"
                description="您的照片请上传以下案例相似的比例"
                type="warning"
                showIcon
        />
        <img src="http://localhost:8088/singerimg/Wiz Khalifa.jpg" alt="例子" style="margin-left:170px;margin-top: 30px">
        <a-button type="primary" @click="submitSingerReq" :loading="submitLoading" :disabled="singerReqForm.music===''||
        singerReqForm.img===''||singerReqForm.country===''
        ||singerReqForm.details===''||singerReqForm.reason===''" block style="margin-top: 30px">
            提交
        </a-button>
        </div>
        <div v-show="existSinger===0">
            <a-result style="height: 850px"
                    title="您的音乐人申请已经成功提交！"
                    subTitle="请等待管理员进行审核，审核将在24小时之内完成，届时请登录系统查看结果"
            >
                <template v-slot:extra>
                    <a-button type="primary" key="console" @click="goBack">返回</a-button>
                </template>
            </a-result>
        </div>
        <div v-show="existSinger===1">
            <a-result style="height: 850px"
                      status="success"
                      title="您的音乐人申请已通过审核"
                      subTitle="点击按钮更新您的账号"
            >
                <template v-slot:extra>
                    <a-button type="primary" key="console" @click="becomeSinger">更新</a-button>
                </template>
            </a-result>
        </div>
        <div v-show="existSinger===-1">
            <a-result style="height: 850px"
                      status="error"
                      title="审核失败"
            >
                <template v-slot:extra>

                    <a-button type="primary" key="console" @click="clearFailSubmit">点击确认</a-button>
                </template>
                <div style="text-align: center">
                    <p style="font-size: 16px;">
                        <strong>您的审核失败可能是由以下所造成，请检查您的信息，并重新提交:</strong>
                    </p>
                    <p>
                        <a-icon :style="{ color: 'red' }" type="close-circle" /> 个人简介过于简单
                    </p>
                    <p>
                        <a-icon :style="{ color: 'red' }" type="close-circle" /> 照片尺寸不符合规范
                    </p>
                    <p>
                        <a-icon :style="{ color: 'red' }" type="close-circle" /> 作品没有达到我们的预期要求
                    </p>
                </div>
            </a-result>
        </div>
    </div>
</template>

<script>
    export default {
        name: "SingerRequest",
        created(){
            this.existSingerReq();
        },
        data(){
            return{
                singerReqForm:{
                    userid:JSON.parse(localStorage.getItem('loginUser')).userid,
                    country:'',
                    reason:'',
                    details:'',
                    img:'',
                    music:''
                },
                singerReqRules:{

                },
                submitLoading:false,
                imgURL:'',
                musicURL:'',
                existSinger:''
            }
        },
        methods:{
            clearFailSubmit:function(){
                this.axios.get('/user/clearFailSubmit?userid='+this.singerReqForm.userid)
                .then(res=>{
                    this.$router.push('/userInfo');
                }).catch(err=>{
                    console.log(err);
                })
            },
            goBack:function(){
                this.$router.push('/userInfo');
            },
            becomeSinger:function(){
                this.axios.get('/user/becomeSinger?userid='+this.singerReqForm.userid)
                .then(res=>{
                    if(res.data.data){
                        this.$router.push('/login');
                        localStorage.clear();
                        sessionStorage.clear();
                        this.$message.success("请重新登录!");
                    }else {
                        this.$message.error("请重试");
                    }
                }).catch(err=>{
                    console.log(err);
                })
            },
            submitSingerReq:function(){
                this.submitLoading=true;
                let form=this.$qs.stringify(this.singerReqForm);
                this.axios.post('/user/submitSingerReq',form)
                .then(res=>{
                    if(res.data.data){
                        this.submitLoading=false;
                        this.existSingerReq();
                    }else{
                        this.$message.error("提交失败!");
                    }
                }).catch(err=>{
                    console.log(err);
                })

            },
            existSingerReq:function () {
                this.axios.get('/user/existSingerReq?userid='+this.singerReqForm.userid)
                .then(res=>{
                    this.existSinger=res.data.data;
                }).catch(err=>{
                    console.log(err);
                })
            },
            handleChange(info) {
                const status = info.file.status;
                if (status !== 'uploading') {
                    console.log(info.file, info.fileList);
                }
                if (status === 'done') {
                    this.$message.success(`${info.file.name} 上传成功！`);
                    if(info.file.response.data.imgURL!==undefined&&info.file.response.data.imgURL!==null){
                        this.singerReqForm.img=info.file.response.data.imgURL;
                    }
                    if(info.file.response.data.musicURL!==undefined&&info.file.response.data.musicURL!==null){
                        this.singerReqForm.music=info.file.response.data.musicURL;
                    }
                } else if (status === 'error') {
                    this.$message.error(`${info.file.name} 上传失败！`);
                }
            },
            handleReject(){
                this.$message.error("仅支持上传.jpg, .jpeg, .png, .jfif, .mp3, .ogg格式")
            }
        }

    }
</script>

<style scoped>

</style>