const express = require('express');
const router = express.Router();

const Url = require('../models/Url');

// @route     GET /:code
// @desc      Redirect to long/original URL
router.get('/health', async (req,res) => {
  return res.status(200).json('healthy');
});
router.get('/:code', async (req, res) => {
  try {
    const url = await Url.findOne({ urlCode: req.params.code });

    if (url) {
      return res.redirect(url.longUrl);
      mongoose.disconnect();
    } else {
      return res.status(404).json('No url found');
      mongoose.disconnect();
    }
  } catch (err) {
    console.error(err);
    res.status(500).json('Server error');
  }
});


module.exports = router;
