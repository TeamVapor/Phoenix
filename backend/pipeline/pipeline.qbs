import qbs
Project{
    Product{
        type:["dynamiclibrary","prheaders","puheaders"]
        name:"pipeline"


        Depends{name:'cpp'}
        Depends{name:  "Qt"; submodules:["core","core-private"]}

        cpp.defines:['PHOENIX_PIPELINE']


        Group {
            qbs.install: true
            fileTagsFilter: "dynamiclibrary"
            qbs.installDir: "/lib"
        }
    }
}

