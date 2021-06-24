from aiohttp import web
import brotli

async def response(request):
    headers = {"Content-Encoding": "br"}
    return web.Response(body=brotli.compress(b"data"), headers=headers)


app = web.Application()
app.add_routes([web.get('/', response)])

if __name__ == '__main__':
    web.run_app(app, host='0.0.0.0', port=8099)