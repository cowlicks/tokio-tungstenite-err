use tokio_tungstenite::connect_async;

use tokio::runtime::Runtime;

type ExternalRuntime = *mut Runtime;

#[no_mangle]
pub extern fn init_runtime() -> ExternalRuntime {
    let rt = Runtime::new().unwrap();

    let boxed = Box::new(rt);
    let o = Box::into_raw(boxed);
    println!("runtime ready in rust");
    o
}

#[no_mangle]
pub extern fn connect(rt: ExternalRuntime) -> i32 {
    let rt = unsafe { Box::from_raw(rt) };
    let wr = rt.block_on(async {
        let url = "ws://localhost:8081/ws";
        println!("Trying to connecto instrument at {}", url);
        let wr = connect_async(url).await;
        println!("Connected");
        wr
    });
    66
}
