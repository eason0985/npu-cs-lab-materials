namespace cpp match_server
struct User{
    1:i32 id,
    2:string name,
}
service Match{
    i32 add_user(1:User user,2:string info),
    i32 remove_user(1:User user,2:string info),
    i32 list_user(1:string output_file,2:string info),
    i32 get_random(1:i32 num,2:string output_file,3:string info),
}
