import qbs
Project {
    minimumQbsVersion: "1.7.1"
    name:"phoenix-vapor"
    property string deployDir:"/build"
    SubProject{
        filePath: "backend/backend.qbs"
        Properties {
            deployDir: this.deployDir
        }
    }
    SubProject{
        filePath: "frontend/frontend.qbs"
        Properties {
            deployDir: this.deployDir
        }
    }
//    SubProject{
//        filePath: "frontend/frontend.qbs"
//        Properties {
//            deployDir: this.deployDir
//        }
//    }


}

