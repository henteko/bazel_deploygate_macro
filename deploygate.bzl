def _impl(ctx):
  out = ctx.outputs.result
  apk = ctx.file.apk
  name = ctx.attr.user_name
  api_key = ctx.attr.api_key
  ctx.action(
    outputs = [out],
    inputs = [apk],
    command = "curl -F 'file=@%s' -F 'token=%s' -F 'message=sample' https://deploygate.com/api/users/%s/apps > %s" % (apk.path, api_key, name, out.path),
  )
  
deploygate = rule(
  implementation=_impl,
  attrs={
    "user_name": attr.string(mandatory=True),
    "api_key": attr.string(mandatory=True),
    "apk": attr.label(mandatory=True, allow_files=True, single_file=True),
  },
  outputs = {"result": "%{name}_result.txt"},
)
