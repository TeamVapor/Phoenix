import qbs
Project{
    Product{
        type:["dynamiclibrary","prheaders","puheaders"]
        name:"input"


        Depends{name:'cpp'}
        Depends{name:  "Qt"; submodules:["core","core-private"]}

        cpp.defines:['PHOENIX_INPUT']


        Group {
            qbs.install: true
            fileTagsFilter: "dynamiclibrary"
            qbs.installDir: "/lib"
        }
    }
}

