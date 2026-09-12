// Run with Node.js and playwright/sharp available through NODE_PATH.
const fs=require('fs'), path=require('path');
const {pathToFileURL}=require('url');
const {chromium}=require('playwright'), sharp=require('sharp');
const root=path.resolve(__dirname,'..');
const palette=JSON.parse(fs.readFileSync(path.join(__dirname,'preview-palette.json')));
const about=fs.readFileSync(path.join(root,'Mod/About/About.xml'),'utf8');
const versions=[...about.match(/<supportedVersions>([\s\S]*?)<\/supportedVersions>/)[1].matchAll(/<li>(\d+(?:\.\d+)+)<\/li>/g)].map(m=>m[1]);
versions.sort((a,b)=>{const x=a.split('.').map(Number),y=b.split('.').map(Number);for(let i=0;i<Math.max(x.length,y.length);i++){const d=(y[i]||0)-(x[i]||0);if(d)return d;}return 0;});
function lum(rgb){const a=rgb.map(v=>{v/=255;return v<=.04045?v/12.92:((v+.055)/1.055)**2.4});return .2126*a[0]+.7152*a[1]+.0722*a[2]}
const rgb=h=>h.match(/\w\w/g).map(v=>parseInt(v,16));
function contrast(a,b){const x=lum(a),y=lum(b);return (Math.max(x,y)+.05)/(Math.min(x,y)+.05)}
(async()=>{
const browser=await chromium.launch({executablePath:process.env.CHROME_PATH||'C:/Program Files/Google/Chrome/Application/chrome.exe',headless:true});
try {
const page=await browser.newPage({viewport:{width:896,height:504},deviceScaleFactor:1});
await page.goto(pathToFileURL(path.join(__dirname,'Preview.html')).href);
await page.evaluate(async ({palette,version})=>{await window.preparePreview(palette,version)}, {palette,version:versions[0]});
await page.locator('.scene').evaluate(async el=>{const image=new Image();image.src=getComputedStyle(el).backgroundImage.slice(5,-2);await image.decode()});
const client=await page.context().newCDPSession(page);await client.send('DOM.enable');await client.send('CSS.enable');
const {root:doc}=await client.send('DOM.getDocument');
const report={version:versions[0],fonts:{},contrast:{},bounds:{}};
for(const selector of ['h1','h1 span','.tag','.summary','.version']){
 const {nodeId}=await client.send('DOM.querySelector',{nodeId:doc.nodeId,selector});
 report.fonts[selector]=(await client.send('CSS.getPlatformFontsForNode',{nodeId})).fonts;
 report.bounds[selector]=await page.locator(selector).boundingBox();
}
const final=path.join(root,'Mod/About/Preview.png');
await page.screenshot({path:final});
await sharp(final).resize({width:268}).toFile(path.join(__dirname,'preview-268.png'));
await page.addStyleTag({content:'.plate,.version { visibility:hidden; }'});
const bg=await page.screenshot({path:path.join(__dirname,'preview-background.png')});
const {data,info}=await sharp(bg).removeAlpha().raw().toBuffer({resolveWithObject:true});
for(const [selector,key] of [['h1','inkPrimary'],['h1 span','inkSecondary'],['.tag','inkSecondary'],['.summary','inkPrimary']]){
 const b=report.bounds[selector];let min=Infinity;
 for(let y=Math.floor(b.y);y<Math.ceil(b.y+b.height);y++)for(let x=Math.floor(b.x);x<Math.ceil(b.x+b.width);x++){
 const i=(y*info.width+x)*info.channels;min=Math.min(min,contrast(rgb(palette[key]),Array.from(data.subarray(i,i+3))));}
 report.contrast[selector]=Number(min.toFixed(3));
}
report.contrast.badge=Number(contrast(rgb(palette.badgeInk),rgb(palette.accent)).toFixed(3));
report.bytes=fs.statSync(final).size;
fs.writeFileSync(path.join(__dirname,'preview-qa.json'),JSON.stringify(report,null,2)+'\n');
console.log(JSON.stringify(report,null,2));
if(Object.values(report.contrast).some(v=>v<4.5))throw Error('Contrast below 4.5');
if(report.bytes>=900000)throw Error('Preview exceeds 900 KB');
if(Object.values(report.fonts).some(fonts=>!fonts.length||fonts.some(f=>!/^Segoe UI(?: Semibold)?$/.test(f.familyName))))throw Error('Unexpected font');
}finally{await browser.close()}
})().catch(e=>{console.error(e);process.exitCode=1});
