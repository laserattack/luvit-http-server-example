local function pwd()
    return io.popen("pwd"):read('*l')
end

return {
    pwd = pwd
}