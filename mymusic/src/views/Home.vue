<template>
      <a-layout>
          <a-layout-header style="background-color: #2d8cf0;">
              <Menu @on-select="nav" mode="horizontal" theme="primary" active-name="1">
                  <MenuItem name="1">
                      <Icon type="ios-home" />
                      首页
                  </MenuItem>
                  <MenuItem name="2">
                      <Icon type="ios-headset" />
                      音乐
                  </MenuItem>
                  <MenuItem name="3">
                      <Icon type="ios-people" />
                      音乐人
                  </MenuItem>
                  <MenuItem name="4">
                      <Icon type="ios-person" />
                      个人中心
                  </MenuItem>
                  <a-input-search placeholder="input search text" style="width: 200px;margin-left: 45%" @search="search" />
                  <a-button type="danger" style="margin-left: 2%" @click="logout">注销</a-button>
              </Menu>
          </a-layout-header>
              <a-layout >
              <a-layout-content  :style="{ background: '#f8f8f9', padding: '20px 20%', margin: 0, minHeight: '280px' }">
                  <router-view></router-view>
              </a-layout-content>
              </a-layout>
          <a-layout-footer style="text-align: center;background-color:white">
              <a-icon type="customer-service" /> Jayho Music
          </a-layout-footer>
          </a-layout>
</template>

<script>
// @ is an alias to /src
export default {
  name: 'Home',
    data(){
      return{
      }
    },
    methods:{
        search:function(value){
            this.axios.get('/user/search?value='+value)
            .then(res=>{
                if(res.data.data.musicList.length===0&&res.data.data.singerList.length===0){
                    this.$message.warning('没有搜索到结果哦');
                }else{
                        this.$router.push({path:'/search',query:{searchResult:JSON.stringify(res.data.data)}})
                }
                console.log(res);
            }).catch(err=>{
                console.log(err);
            })
        },
        logout:function () {
            this.$router.push('/login');
            this.$message.info("成功注销!");
            localStorage.clear();
            sessionStorage.clear();
        },
        nav:function (name) {
            if(name==='1'){
                this.$router.push('/welcome')
            }
            else if(name==='2'){
                this.$router.push('/music')
            }
            else if(name==='3'){
                this.$router.push('/singer')
            }
            else if(name==='4'){
                this.$router.push('/userInfo')
            }
        },
    },
  components: {
  }
}
</script>
<style scoped>

</style>