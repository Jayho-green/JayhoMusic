<template>
    <div>
       <img :src="singerInfo.singerimg" :alt="singerInfo.singername" style="margin-left: 18%;margin-top: 30px">
        <div style="font-size: 25px;text-align: center;margin-top: 30px">{{singerInfo.singername}}</div>
        <div style="font-size: 20px;text-align: center;margin-top: 20px">
            <a-tooltip placement="right">
                <template slot="title">
                    <div class="activeClass" v-for="(music,index) in singerInfo.music" :key="index" @click="toMusicInfo(music)">
                        {{music.musicname}}
                    </div>
                </template>
            <span>音乐数:{{singerInfo.musicnum}}</span>
            </a-tooltip>
        </div>
        <div style="font-size: 20px;text-align: center;margin-top: 20px">{{singerInfo.singercountry}}人</div>
        <div style="font-size: 20px;margin-top: 100px">{{singerInfo.singername}}的简介:</div>
        <a-divider></a-divider>
        <a-card>
            <div style="margin: 20px">{{singerInfo.singerdetails}}</div>
        </a-card>
    </div>
</template>

<script>
    export default {
        name: "SingerInfo",
        data(){
            return{
                singerInfo:{}
            }
        },
        mounted(){
            this.getSingerInfo();
        },
        methods:{
            toMusicInfo:function(music){
                this.$router.push({path:'/musicInfo',query:{music:JSON.stringify(music)}})
            },
            getSingerInfo:function () {
                this.axios.get('/user/getSingerInfo?singerid='+this.$route.query.singerid)
                .then(res=>{
                    console.log(res);
                    this.singerInfo=res.data.data
                }).catch(err=>{
                    console.log(err);
                })
            }
        }
    }
</script>

<style scoped>
    :hover.activeClass{
        color: #2d8cf0;
        cursor: pointer;
    }
</style>