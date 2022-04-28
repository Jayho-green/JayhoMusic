<template>
    <div>
        <a-row>
            <a-col :span="10" style="margin-top: 20px">
        <img :src="listInfo.listimg" :alt="listInfo.listname" height="300" width="300">
            </a-col>
            <a-col :span="10">
                    <p style="margin-top: 50px;font-size: 22px">{{listInfo.listname}}</p>
                <a-divider></a-divider>
                <a-button type="primary" icon="plus-circle" v-show="!existCollectList" @click="collectList(listInfo.listid)">收藏</a-button>
                <a-button type="danger" icon="minus-circle" v-show="existCollectList" @click="removeCollectList(listInfo.listid)">取消收藏</a-button>
                    <p style="margin-top: 20px">{{listInfo.listintro}}</p>
            </a-col>
           <a-col :span="20" style="margin-top: 70px">
               <a-table :dataSource="data" >
                   <a-table-column dataIndex="key" key="key">
                       <span slot="title">序号</span>
                   </a-table-column>
                   <a-table-column dataIndex="musicname" key="musicname">
                       <span slot="title">音乐名</span>
                       <template slot-scope="musicname">
          <span style="cursor: pointer" @click="toMusicInfo(musicname)">{{ musicname }}</span>
                       </template>
                   </a-table-column>
                   <a-table-column dataIndex="singername" key="singername">
                       <span slot="title">音乐人</span>
                       <template slot-scope="singername">
                           <span style="cursor: pointer" @click="toSingerInfo(singername)">{{ singername }}</span>
                       </template>
                   </a-table-column>
                   <a-table-column dataIndex="hot" key="hot">
                       <span slot="title">热度</span>
                       <!--aa-->
                   </a-table-column>
               </a-table>
           </a-col>
        </a-row>
    </div>
</template>

<script>
    export default {
        name: "ListInfo",
        data(){
            return{
              listInfo:{},
                musics:[],
                existCollectList:false,
                data:[]
            }
        },
        mounted(){
            this.getListInfo();
        },
        methods:{
            getListInfo:function () {
                this.axios.get('/user/getListInfo?listid='+this.$route.query.listid+'&userid='+JSON.parse(localStorage.getItem('loginUser')).userid)
                .then(res=>{
                    console.log(res);
                    this.listInfo=res.data.data.list;
                    let musics=res.data.data.musics;
                    let i=1;
                    for(let music of musics){
                        music.key=i;
                        i++;
                    }
                    this.data=res.data.data.musics;
                    this.existCollectList=res.data.data.existCollectList;
                }).catch(err=>{
                    console.log(err);
                })
            },
            toMusicInfo:function (musicname) {
                this.axios.get('/user/getMusicByMusicName?musicname='+musicname)
                .then(res=>{
                    console.log(res);
                    this.$router.push({path:'/musicInfo',query:{music:JSON.stringify(res.data.data)}})
                }).catch(err=>{
                    console.log(err);
                })
            },
            toSingerInfo:function (singername) {
                this.axios.get('/user/getSingerBySingerName?singername='+singername)
                    .then(res=>{
                        console.log(res);
                        this.$router.push({path:'/singerInfo',query:{singerid:res.data.data.singerid}})
                    }).catch(err=>{
                    console.log(err);
                })
            },
            collectList:function (listid) {
                this.axios.get('/user/collectList?listid='+listid+'&userid='+JSON.parse(localStorage.getItem('loginUser')).userid)
                .then(res=>{
                    if(res.data.data){
                        this.$message.success("成功收藏");
                        this.getListInfo();
                    }else {
                        this.$message.success("收藏失败");
                    }
                }).catch(err=>{
                    console.log(err);
                })
            },
            removeCollectList:function (listid) {
                this.axios.get('/user/removeCollectList?listid='+listid+'&userid='+JSON.parse(localStorage.getItem('loginUser')).userid)
                    .then(res=>{
                        if(res.data.data){
                            this.$message.success("成功取消收藏");
                            this.getListInfo();
                        }else {
                            this.$message.success("取消收藏失败");
                        }
                    }).catch(err=>{
                    console.log(err);
                })
            }
        }
    }
</script>

<style scoped>

</style>