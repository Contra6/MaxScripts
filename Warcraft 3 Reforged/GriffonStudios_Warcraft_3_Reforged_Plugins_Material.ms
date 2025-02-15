/*
    Written by Taylor Mouse � 2020
    for
    Warcraft 3 Reforged

*/

plugin Material WC3RefMaterial
    name: "Warcraft 3 Reforged Standard"
    classID:#(0xbc1a66d, 0x64d12aa1)
    category:"Warcraft 3 Reforged"
    extends:Standard
    replaceUI:true 
    version:1
(

    
    parameters main rollout:params
    (
        priorityPlane   type:#integer   animatable:false  ui:spn_priority
        material_alpha  type:#float     animatable:true   ui:spn_alpha
        filtermode      type:#integer   animatable:false  ui:lb_filterMode
        
        unlit       type:#boolean animatable:false
        envmap      type:#boolean animatable:false
        wrapwidth   type:#boolean animatable:false
        wrapheight  type:#boolean animatable:false
        twosided    type:#boolean animatable:false
        nofog       type:#boolean animatable:false
        nodepthtest type:#boolean animatable:false
        nodepthset  type:#boolean animatable:false
        
        diffuse_map     type:#texturemap animatable:false ui:mb_diffuse
        normal_map      type:#texturemap animatable:false ui:mb_normal
        orm_map         type:#texturemap animatable:false ui:mb_orm  --> R = occlusion, G = Roughness, B = Metal
        teamcolor_map   type:#texturemap animatable:false ui:mb_teamcolor--> usually Alpha layer of the orm map
        emissive_map    type:#texturemap animatable:false ui:mb_emissive
        emissive_alpha  type:#float      animatable:true  ui:spn_emissive
        alphamask_map   type:#texturemap animatable:false ui:mb_alphamask
        reflection_map  type:#texturemap animatable:false ui:mb_reflection
       
       /* filterMode
         0x0: Opaque
         0x1: Mask
         0x2: Blend
         0x3: Add
         0x4: BlendAdd
         0x5: Mod
         0x6: Mod 2x
         0x7: --> 0x0
        */
        /* ShadingFlag -- > bit.and seqs.Flags 0x1
             0x1: Unlit
             0x2: Environment map
             0x4: Wrap Width
             0x8: Wrap Height
             0x10: 2-sided
             0x20: No fog
             0x40: no depth test
             0x80: no depth set               
             0x100: Fallback
        */

        on material_alpha set val do 
        (
            delegate.opacity = val
        )
        on diffuse_map set val do 
		(
            delegate.diffuseMap = diffuse_map
            
            if (diffuse_map != undefined ) then showTextureMap this delegate.diffusemap true
		)
       
        
    )
    rollout params "Material Texture Parameters"
    (
        dropdownlist lb_filterMode "Filter Mode" items:#("Opaque","Mask","Blend", "Add", "BlendAdd", "Mod", "Mod2x") width:150
        
        spinner spn_priority "Priority :" range:[0,1000,0] type:#integer width:60 offset:[0,-27] width:100 align:#right
        spinner spn_alpha  "Alpha :"     range:[0,100.0,100.0] offset:[0,0] width:60 align:#right
        
        checkbox cbx_unlit "Unlit"
        checkbox cbx_environment "Environment" 
        checkbox cbx_wrapwidth "Wrap Width" 
        checkbox cbx_wrapheight "Wrap Height" 
        checkbox cbx_twosided "2-sided" offset:[200,-80]
        checkbox cbx_nofog "No fog" offset:[200,0]
        checkbox cbx_nodepthtest "No depth test" offset:[200,0]
        checkbox cbx_nodepthset "No depth set" offset:[200,0]
        
        groupbox grpCommon "Common parameters" height:150 pos:[5,5] width:315
        
        label lbl1 "Diffuse . . . . ." align:#left offset:[0,30]
            mapbutton mb_diffuse "(drag & drop texture here)" height:22 offset:[20,-25] width:200
        
        label lbl2 "Normal . . . . ." align:#left offset:[0,10]
            mapbutton mb_normal  "(drag & drop texture here)" height:22 width:200  offset:[20,-25]
        
        label lbl3 "ORM . . . . . . ." align:#left offset:[0,10]
            mapbutton mb_orm     "(drag & drop texture here)" height:22 width:200  offset:[20,-25]
        
        label lbl4 "Team Color . . ."   align:#left offset:[0,10]
            mapbutton mb_teamcolor "(drag & drop texture here)" height:22 width:200  offset:[20,-25]
        
        label lbl5 "Emissive . . . ." align:#left offset:[0,10]
            mapbutton mb_emissive  "(drag & drop texture here)" height:22 width:200 offset:[20,-25] 
            spinner spn_emissive "Alpha:"   range:[0,100.0,100.0] align:#right width:50 offset:[-30,0]
        
        label lbl6 "Alpha mask . . " align:#left offset:[0,5] 
            mapbutton mb_alphamask "(drag & drop texture here)" height:22 width:200 offset:[20,-25] 
    
        label lbl7 "Reflection . . ."   align:#left offset:[0,10]
            mapbutton mb_reflection "(drag & drop texture here)" height:22 width:200  offset:[20,-25] tooltip:"Select spherical reflection map"
    
        groupbox grpMaps "Texture Maps" height:280 pos:[5,160] width:315 
    
        
    )
    
    
    on create do
    (

        delegate.shadertype = 1
        filtermode = 1
        material_alpha = 100
        
    )
    
    
)

