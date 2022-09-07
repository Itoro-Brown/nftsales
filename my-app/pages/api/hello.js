// Next.js API route support: https://nextjs.org/docs/api-routes/introduction

export default function handler(req, res) {
  const tokenId = req.query.tokenId;
  const name = `SapaNft ${tokenId}`;
  const description =
    "This Nft was made to serve as a means to fight poverty amongst young people";
  const image = `https://images.unsplash.com/photo-1644151015485-f9b2197352f8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTh8fG5mdHN8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60 ${tokenId}`;
  return res.json({
    name: name,
    description: description,
    image: image,
  });
}
