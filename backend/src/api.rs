use clipboard::ClipboardContext;
use clipboard::ClipboardProvider;
use rand::{thread_rng, Rng};

const ALPHABETS: &[u8] = b"ABCDEFGHIJKLMNOPQRSTUVWXYZ\
                        abcdefghijklmnopqrstuvwxyz\
                        0123456789!@#$%^&*()-_=+[]{}|;:<>,.?/\\";

pub fn copy_password(pass: String) {
    let mut ctx: ClipboardContext = ClipboardProvider::new().unwrap();
    ctx.set_contents(pass).unwrap();
}

pub fn generate_password(len: usize) -> String {
    let mut rng = thread_rng();
    (0..len)
        .map(|_| {
            let idx = rng.gen_range(0..ALPHABETS.len());
            ALPHABETS[idx] as char
        })
        .collect::<String>()
}
