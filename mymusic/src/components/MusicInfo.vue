<template>
    <div>
        <audio :src="musicInfo.musicfile" ref='audio' loop id="player"></audio>
       <div style="font-size: 25px;text-align: center;margin-top: 30px">{{musicInfo.musicname}}</div>
        <div style="font-size: 15px;text-align: center;margin-top: 20px">{{musicInfo.singername}}</div>
        <div class="circle" >
            <img :class="[isPlaying?'activecircleimg':'circleimg']"
                    :src="musicInfo.musicimg" height="500px" width="500px" :alt="musicInfo.musicname"/></div>
        <a-icon class="playIcon" type="step-backward" @click="preMusic" />
       <a-icon class="playIcon" type="caret-right" @click="playMusic" v-show="!isPlaying"/>
        <a-icon class="playIcon" type="pause" @click="stopMusic" v-show="isPlaying"/>
        <a-icon class="playIcon" type="step-forward" @click="nextMusic" />
        <div style="font-size: 23px;margin-left:15%;margin-right:15%;margin-top: 200px;margin-bottom: 30px">
            评论区
            <a-tooltip placement="top">
                <template slot="title">
                    <span>发表评论</span>
                </template>
                <a-icon type="form" class="activeClass" @click="commentModal=true"/>
            </a-tooltip>

            <a-tooltip placement="top">
                <template slot="title">
                    <span>收藏此音乐</span>
                </template>
            <a-icon type="plus-circle" theme="twoTone" class="activeClass" @click="collect" v-show="!existCollect"/>
            </a-tooltip>

            <a-tooltip placement="top">
                <template slot="title">
                    <span>取消收藏</span>
                </template>
            <a-icon type="minus-circle" theme="twoTone" class="activeClass" @click="removeCollect" twoToneColor="red"
                    v-show="existCollect"/>
            </a-tooltip>
            <span style="font-size: 16px;margin-left: 30px">({{musicInfo.hot}}人收藏了此音乐)</span>
        </div>
        <a-card style="margin: 0 15%" :bordered="false">
        <a-list
                class="comment-list"
                :header="`${commentList.length}条评论`"
                itemLayout="horizontal"
                :dataSource="commentList"
        >
            <a-list-item slot="renderItem" slot-scope="item">
                <a-comment :author="item.username" >
                    <p slot="content">{{item.comment}}</p>
                    <a-tooltip slot="datetime" :title="item.date">
                        <span>{{item.date}}</span>
                    </a-tooltip>
                </a-comment>
            </a-list-item>
        </a-list>
        </a-card>
        <a-modal
                title="发表评论"
                :visible="commentModal"
        >
            <template slot="footer">
                <a-button @click="commentModal=false">取消</a-button>
                <a-button type="primary" @click="submitComment" :disabled="existComment">
                    提交
                </a-button>
            </template>
            <a-textarea placeholder="发表你的感想(不能超过300字哦)"  v-model="commentValue" :rows="5"/>
        </a-modal>
    </div>
</template>
<script>
    export default {
        name: "MusicInfo",
        data(){
            return{
                musicInfo:{},
                commentList:[],
                isPlaying:false,
                commentModal:false,
                commentValue:'',
                existCollect:false
            }
        },
        created:function () {
            this.musicInfo=JSON.parse(this.$route.query.music);
            this.getMusicInfo(this.musicInfo.musicid);
        },
        computed:{
            existComment:function(){
                if(this.commentValue===''||this.commentValue.length>300){
                    return true;
                }else{
                    return false;
                }
            },
        },
        methods:{
            collect:function(){
                this.axios.get('/user/addCollect?userid='+JSON.parse(localStorage.getItem('loginUser')).userid+'&musicid='+this.musicInfo.musicid)
                .then(res=>{
                    if(res.data.data){
                        this.musicInfo.hot=this.musicInfo.hot+1;
                        this.getMusicInfo(this.musicInfo.musicid);
                        this.$message.success('收藏成功！');
                    }else {
                        this.$message.error('收藏失败!');
                    }
                }).catch(err=>{
                    console.log(err);
                })
            },
            removeCollect:function(){
                this.axios.get('/user/removeCollect?userid='+JSON.parse(localStorage.getItem('loginUser')).userid+'&musicid='+this.musicInfo.musicid)
                    .then(res=>{
                        if(res.data.data){
                            this.musicInfo.hot=this.musicInfo.hot-1;
                            this.getMusicInfo(this.musicInfo.musicid);
                            this.$message.success('成功取消收藏！');
                        }else {
                            this.$message.error('取消收藏失败!');
                        }
                    }).catch(err=>{
                    console.log(err);
                })
            },
            submitComment:function(){
             this.axios.get('/user/addComment?userid='+JSON.parse(localStorage.getItem('loginUser')).userid+'&musicid='
                +this.musicInfo.musicid+'&comment='+this.commentValue)
                .then(res=>{
                    if(res.data.data){
                        this.commentModal=false;
                        this.$message.success('评论成功！');
                        this.commentValue='';
                        this.getMusicInfo(this.musicInfo.musicid);
                    }else {
                        this.$message.error('评论失败!');
                    }
                }).catch(err=>{
                    console.log(err);
                })
            },
            getMusicInfo(musicid){
                this.axios.get('/user/getMusicInfo?musicid='+musicid+'&userid='+JSON.parse(localStorage.getItem('loginUser')).userid)
                .then(res=>{
                    console.log(res.data.data);
                    this.commentList=res.data.data.commentList;
                    this.existCollect=res.data.data.existCollect;
                }).catch(err=>{
                    console.log(err);
                })
            },
            playMusic:function () {
                let player = document.querySelector('#player');
                if(!this.isPlaying){
                    player.play();
                    this.isPlaying = true;
                }
            },
            stopMusic:function () {
                let player = document.querySelector('#player');
                if(this.isPlaying){
                    player.pause();
                  /*  player.currentTime = 0;   //回到音乐初始位置*/
                    this.isPlaying = false;
                }
            },
            nextMusic:function(){
                this.axios.get('/user/getNextMusic?musicid='+this.musicInfo.musicid)
                .then(res=>{
                    console.log(res);
                    this.musicInfo=res.data.data;
                    this.isPlaying = false;
                    this.getMusicInfo(res.data.data.musicid);
                }).catch(err=>{
                    console.log(err);
                });
            },
            preMusic:function () {
                this.axios.get('/user/getPreMusic?musicid='+this.musicInfo.musicid)
                    .then(res=>{
                        console.log(res);
                        this.musicInfo=res.data.data;
                        this.isPlaying = false;
                        this.getMusicInfo(res.data.data.musicid);
                    }).catch(err=>{
                    console.log(err);
                });
            }
        }
    }
</script>

<style scoped>
    .circle{
        margin:30px auto;
        text-align: center;
    }
    .circleimg{
        border-radius:50%;
    }
    .activecircleimg{
        border-radius:50%;
        -webkit-transform: rotate(360deg);
        animation: rotation 5s linear infinite;
        -moz-animation: rotation 5s linear infinite;
        -webkit-animation: rotation 5s linear infinite;
        -o-animation: rotation 5s linear infinite;
    }
    @-webkit-keyframes rotation{
        from {-webkit-transform: rotate(0deg);}
        to {-webkit-transform: rotate(360deg);}
    }
    .playIcon{
        font-size: 50px;
        margin-top: 70px;
        margin-left: 21%;
        cursor: pointer;
    }
    .activeClass{
        margin-left: 30px;
        font-size: 30px;
        cursor: pointer;
    }
    :hover.playIcon{
        color: #2d8cf0;
    }
    :hover.activeClass{
        color: #2d8cf0;
    }
</style>